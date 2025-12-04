import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:clinics/core/api/dio_client.dart';
import 'package:clinics/features/auth/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

@injectable
class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState.initial());

  final Dio _dio = DioClient.instance;

  Future<void> fetchUser(String userId) async {
    try {
      emit(const UserState.loading());
      final response = await _dio.get('/clinics/$userId');

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data);

        emit(UserState.loaded(user));
      } else {
        emit(const UserState.error('Failed to fetch user data'));
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';

      if (e.response != null) {
        errorMessage = e.response?.data['message'] ?? 'Server error';
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage =
            'Connection timeout. Please check your internet connection.';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Request timeout. Please try again.';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage =
            'Connection error. Please check your internet connection.';
      }

      emit(UserState.error(errorMessage));
    } catch (e) {
      emit(UserState.error('Unexpected error: ${e.toString()}'));
    }
  }

  void clearUser() {
    emit(const UserState.initial());
  }
}
