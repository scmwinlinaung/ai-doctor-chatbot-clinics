import 'package:clinics/core/api/dio_client.dart';
import 'package:clinics/features/booking/model/clinic_booking_model.dart';
import 'package:clinics/features/booking/model/clinic_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class BookingService {
  final Dio _dio = DioClient.instance;
  Future<List<ClinicBookingModel>> fetchClinicBooking(
      String? username,
      String? phonenumber,
      BookingStatus? status,
      String? fromDate,
      String? toDate) async {
    // Build query parameters
    final Map<String, dynamic> queryParams = {};

    if (username != null && username.isNotEmpty) {
      queryParams['username'] = username;
    }
    if (phonenumber != null && phonenumber.isNotEmpty) {
      queryParams['phonenumber'] = phonenumber;
    }
    if (status != null) {
      queryParams['status'] = status.name;
    }
    if (fromDate != null && fromDate.isNotEmpty) {
      queryParams['fromDate'] = fromDate;
    }
    if (toDate != null && toDate.isNotEmpty) {
      queryParams['toDate'] = toDate;
    }

    final response =
        await _dio.get('/clinics/bookings', queryParameters: queryParams);
    print("Bookding = ${response.data}");
    final booking = (response.data as List<dynamic>)
        .map(
            (item) => ClinicBookingModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return booking;
  }

  Future<int> confirmBooking(
      String bookingId, String doctorId, String date, String time) async {
    final response = await _dio.patch('/bookings/$bookingId/confirm',
        data: {"doctorId": doctorId, "date": date, "time": time});
    return response.statusCode!;
  }

  Future<int> payBooking(String bookingId) async {
    final response = await _dio.patch('/bookings/$bookingId/pay');
    return response.statusCode!;
  }
}
