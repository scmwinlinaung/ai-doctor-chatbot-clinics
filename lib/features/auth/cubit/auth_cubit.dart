import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clinics/core/api/dio_client.dart';
import 'package:clinics/core/config/api_route.dart';
import 'package:clinics/core/util/cryptography.dart';
import 'package:clinics/features/auth/services/token_storage_service.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final TokenStorageService _tokenStorageService;

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

  Future<void> login(String username, String password) async {
    emit(const AuthState.loading());
    try {
      // final hashPassword = Cryptography().hashStringWithSha512(password);
      final Response response = await DioClient.instance.post(
        ApiRoute.login,
        data: {'username': username, 'password': password},
      );
      final dynamic data = response.data;
      final token = data['token'] as String;
      await _tokenStorageService.saveToken(token);

      emit(AuthState.authenticated(token));
    } catch (e) {
      emit(AuthState.unauthenticated(e.toString()));
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
      final hashPassword = Cryptography().hashStringWithSha512(password);
      final Response response = await DioClient.instance.post(
        ApiRoute.register,
        data: {
          'username': username,
          'phoneno': phoneno,
          'password': hashPassword,
          'region': region,
          'city': city,
        },
      );
      final dynamic data = response.data;
      final userId = data['userId'] as String;
      final token = data['token'] as String;
      await _tokenStorageService.saveToken(token);
      await _tokenStorageService.saveUserId(userId);

      emit(AuthState.authenticated(token));
    } catch (e) {
      print(e.toString());
      emit(AuthState.unauthenticated(e.toString()));
    }
  }

  Future<void> changePassword(String phoneno, String newPassword) async {
    emit(const AuthState.loading());
    try {
      Map<String, dynamic> queryParameters = {};
      queryParameters['phoneno'] = phoneno;
      final Response response = await DioClient.instance.put(
        ApiRoute.updatePassword,
        queryParameters: queryParameters,
        data: {'password': newPassword},
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
