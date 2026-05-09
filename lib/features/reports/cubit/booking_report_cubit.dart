import 'package:clinics/features/booking/model/clinic_booking_model.dart';
import 'package:clinics/features/booking/service/booking_service.dart';
import 'package:clinics/features/reports/cubit/booking_report_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BookingReportCubit extends Cubit<BookingReportState> {
  final BookingService _bookingService;

  BookingReportCubit(this._bookingService) : super(const BookingReportState.initial());

  Future<void> fetchBookingReport({
    String? doctorName,
    String? fromDate,
    String? toDate,
  }) async {
    emit(const BookingReportState.loading());
    try {
      final bookings = await _bookingService.fetchClinicBooking(
        doctorName,
        null, // username
        null, // phonenumber
        BookingStatus.confirmed,
        fromDate,
        toDate,
      );
      emit(BookingReportState.success(bookings));
    } catch (e) {
      emit(BookingReportState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
