import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:clinics/features/booking/service/booking_service.dart';
import 'package:clinics/features/booking/model/clinic_booking_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'booking_state.dart';
part 'booking_cubit.freezed.dart';

@injectable
class BookingCubit extends Cubit<BookingState> {
  final BookingService _bookingService;

  BookingCubit(this._bookingService) : super(const BookingState.initial());

  Future<void> fetchClinicBooking({
    String? doctorname,
    String? username,
    String? phonenumber,
    BookingStatus? status,
    String? fromDate,
    String? toDate,
  }) async {
    try {
      emit(const BookingState.loading());
      final bookings = await _bookingService.fetchClinicBooking(
        doctorname,
        username,
        phonenumber,
        status,
        fromDate,
        toDate,
      );
      emit(BookingState.loaded(bookings));
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

      emit(BookingState.error(errorMessage));
    } catch (e) {
      emit(BookingState.error('Unexpected error: ${e.toString()}'));
    }
  }

  Future<void> confirmBooking(String bookingId, String doctorId, String date,
      String time, int serialNumber) async {
    try {
      emit(const BookingState.loading());
      final status = await _bookingService.confirmBooking(
          bookingId, doctorId, date, time, serialNumber);
      if (status == 200) {
        emit(const BookingState.success("Success"));
        await fetchClinicBooking();
      } else {
        emit(const BookingState.error("Cannot Confirm Booking"));
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to confirm booking';

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

      emit(BookingState.error(errorMessage));
    } catch (e) {
      emit(BookingState.error('Failed to confirm booking: ${e.toString()}'));
    }
  }

  Future<void> bookAgain(String clinicId, String doctorId, String userId,
      String date, String time, int? serialNumber) async {
    try {
      emit(const BookingState.loading());
      final status = await _bookingService.bookAgain(
          clinicId, doctorId, userId, date, time, serialNumber ?? 0);
      if (status == 201) {
        emit(const BookingState.success("Success Booking Again"));
        await fetchClinicBooking();
      } else {
        emit(const BookingState.error("Cannot Confirm Booking"));
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to confirm booking';
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

      emit(BookingState.error(errorMessage));
    } catch (e) {
      emit(BookingState.error('Failed to confirm booking: ${e.toString()}'));
    }
  }

  // Future<void> payBooking(String bookingId) async {
  //   try {
  //     emit(const BookingState.loading());
  //     final status = await _bookingService.payBooking(bookingId);
  //     if (status == 200) {
  //       emit(const BookingState.success("Payment processed successfully"));
  //       // Refetch the bookings to get updated data
  //       // await fetchClinicBooking();
  //     } else {
  //       emit(const BookingState.error("Cannot process payment"));
  //     }
  //   } on DioException catch (e) {
  //     String errorMessage = 'Failed to process payment';
  //     if (e.response != null) {
  //       errorMessage = e.response?.data['message'] ?? 'Server error';
  //     } else if (e.type == DioExceptionType.connectionTimeout) {
  //       errorMessage =
  //           'Connection timeout. Please check your internet connection.';
  //     } else if (e.type == DioExceptionType.receiveTimeout) {
  //       errorMessage = 'Request timeout. Please try again.';
  //     } else if (e.type == DioExceptionType.connectionError) {
  //       errorMessage =
  //           'Connection error. Please check your internet connection.';
  //     }

  //     emit(BookingState.error(errorMessage));
  //   } catch (e) {
  //     emit(BookingState.error('Failed to process payment: ${e.toString()}'));
  //   }
  // }

  Future<void> cancelBooking(String userId) async {
    try {
      emit(const BookingState.loading());
      final status = await _bookingService.cancelUserBookings(userId);
      if (status == 200) {
        emit(const BookingState.success("All bookings cancelled successfully"));
        await fetchClinicBooking();
      } else if (status == 403) {
        emit(const BookingState.error("Access denied"));
      } else if (status == 404) {
        emit(const BookingState.error("User not found"));
      } else {
        emit(const BookingState.error("Failed to cancel bookings"));
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to cancel bookings';

      if (e.response != null) {
        errorMessage = e.response?.data['message'] ?? 'Server error';
        if (e.response?.statusCode == 403) {
          errorMessage = 'Access denied';
        } else if (e.response?.statusCode == 404) {
          errorMessage = 'User not found';
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

      emit(BookingState.error(errorMessage));
    } catch (e) {
      emit(BookingState.error('Failed to cancel bookings: ${e.toString()}'));
    }
  }

  void clearBookings() {
    emit(const BookingState.initial());
  }
}
