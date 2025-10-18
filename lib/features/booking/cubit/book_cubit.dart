import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clinics/core/api/dio_client.dart';
import 'package:injectable/injectable.dart';

part 'book_state.dart';
part 'book_cubit.freezed.dart';

@injectable
class BookCubit extends Cubit<BookState> {
  BookCubit() : super(const BookState.initial());
  final Dio _dio = DioClient.instance;
  Future<void> createBooking(String clinicId, String userId) async {
    try {
      emit(const BookState.loading());
      final response = await _dio.post(
        '/bookings',
        data: {"clinicId": clinicId, "userId": userId},
      );
      if (response.statusCode == 201) {
        emit(const BookState.success());
      } else {
        emit(const BookState.error('Failed to book'));
      }
    } catch (e) {
      emit(BookState.error('Unexpected error: ${e.toString()}'));
    }
  }
}
