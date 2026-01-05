import 'package:clinics/core/services/notification_api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clinics/core/api/dio_client.dart';
import 'package:clinics/core/config/api_route.dart';
import 'package:clinics/core/util/cryptography.dart';
import 'package:clinics/core/services/notification_service.dart';
import 'package:clinics/features/auth/services/token_storage_service.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final TokenStorageService _tokenStorageService;
  final NotificationApiService _notificationApiService =
      NotificationApiService();
  AuthCubit(this._tokenStorageService) : super(const AuthState.initial());

  Future<void> checkAuthStatus() async {
    emit(const AuthState.loading());

    try {
      final token = await _tokenStorageService.getToken();

      if (token != null && token.isNotEmpty) {
        emit(AuthState.authenticated(token));
      } else {
        emit(const AuthState.unauthenticated("Token Expired"));
      }
    } catch (e) {
      emit(AuthState.unauthenticated(e.toString()));
    }
  }

  Future<void> login(String phoneno, String password) async {
    emit(const AuthState.loading());

    try {
      final hashPassword = Cryptography().hashStringWithSha512(password.trim());
      final Response response =
          await DioClient.instance.post(ApiRoute.login, data: {
        'username': phoneno.trim(),
        'password': hashPassword,
      });
      final dynamic data = response.data!;
      final clinicId = data['clinic_id'] as String;
      final token = data['token'] as String;
      await _tokenStorageService.saveToken(token);
      await _tokenStorageService.saveClinicId(clinicId);

      // Update FCM token on server after successful login
      final notificationService = NotificationService();
      final fcmToken = notificationService.fcmToken;
      print('FCM Token: $fcmToken');
      if (fcmToken != null && fcmToken.isNotEmpty) {
        try {
          await _notificationApiService.updateFcmToken(clinicId, fcmToken);
        } catch (e) {
          // Log error but don't fail login if FCM token update fails
          print('Error updating FCM token: $e');
        }
      }
      emit(AuthState.authenticated(token));
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.response != null) {
        // Try different possible error message fields
        final responseData = e.response?.data;
        if (responseData is Map<String, dynamic>) {
          errorMessage = responseData['msg'] ??
              responseData['message'] ??
              responseData['error'] ??
              responseData['error_description'] ??
              'Server error';
        } else {
          errorMessage = responseData?.toString() ?? 'Server error';
        }
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage =
            'Connection timeout. Please check your internet connection.';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Request timeout. Please try again.';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage =
            'Connection error. Please check your internet connection.';
      }
      emit(AuthState.unauthenticated(errorMessage));
    } catch (e) {
      final errorMessage =
          e.toString().isEmpty ? 'An unexpected error occurred' : e.toString();
      emit(AuthState.unauthenticated(errorMessage));
    }
  }

  Future<void> signUp(
    String phoneno,
    String username,
    String password,
    String region,
    String city,
  ) async {
    emit(const AuthState.loading());
    try {
      final hashPassword = Cryptography().hashStringWithSha512(password.trim());
      final Response response = await DioClient.instance.post(
        ApiRoute.register,
        data: {
          'username': username.trim(),
          'phoneno': phoneno.trim(),
          'password': hashPassword,
          'region': region.trim(),
          'city': city.trim(),
        },
      );
      final dynamic data = response.data;
      final clinicId = data['clinic_id'] as String;
      final token = data['token'] as String;
      await _tokenStorageService.saveToken(token);
      await _tokenStorageService.saveClinicId(clinicId);

      // Update FCM token on server after successful login
      final notificationService = NotificationService();
      final fcmToken = notificationService.fcmToken;

      if (fcmToken != null && fcmToken.isNotEmpty) {
        try {
          await _notificationApiService.updateFcmToken(clinicId, fcmToken);
        } catch (e) {
          // Log error but don't fail login if FCM token update fails
          print('Error updating FCM token: $e');
        }
      }

      emit(AuthState.authenticated(token));
    } catch (e) {
      emit(AuthState.unauthenticated(e.toString()));
    }
  }

  Future<void> changePassword(String phoneno, String newPassword) async {
    emit(const AuthState.loading());
    try {
      Map<String, dynamic> queryParameters = {};
      queryParameters['phoneno'] = phoneno.trim();
      final Response response = await DioClient.instance.put(
        ApiRoute.updatePassword,
        queryParameters: queryParameters,
        data: {'password': newPassword.trim()},
      );
      if (response.statusCode == 200) {
        emit(const AuthState.succss('Update Password Successfully'));
      } else {
        emit(AuthState.failure(response.statusMessage.toString()));
      }
    } catch (e) {
      emit(AuthState.failure(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await _tokenStorageService.deleteToken();
      emit(const AuthState.unauthenticated("LOGOUT"));
    } catch (e) {
      emit(AuthState.unauthenticated(e.toString()));
    }
  }

  bool get isAuthenticated => state is AuthAuthenticated;
  String? get currentToken => state.whenOrNull(authenticated: (token) => token);
}
