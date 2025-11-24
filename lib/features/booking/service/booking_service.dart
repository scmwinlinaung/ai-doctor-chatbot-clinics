import 'package:clinics/core/api/dio_client.dart';
import 'package:clinics/features/booking/model/clinic_booking_model.dart';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class BookingService {
  final Dio _dio = DioClient.instance;
  Future<List<ClinicBookingModel>> fetchClinicBooking(
      String? doctorname,
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
    if (doctorname != null && doctorname.isNotEmpty) {
      queryParams['doctorname'] = doctorname;
    }
    final response =
        await _dio.get('/clinics/bookings', queryParameters: queryParams);
    final booking = (response.data as List<dynamic>)
        .map(
            (item) => ClinicBookingModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return booking;
  }

  Future<int> confirmBooking(String bookingId, String doctorId, String date,
      String time, int serialNumber) async {
    final response = await _dio.patch('/bookings/$bookingId/confirm', data: {
      "doctorId": doctorId,
      "date": date,
      "time": time,
      "serialNumber": serialNumber
    });
    return response.statusCode!;
  }

  Future<int> bookAgain(String clinicId, String doctorId, String userId,
      String date, String time, int serialNumber) async {
    final response = await _dio.post('/bookings/new_booking', data: {
      "clinicId": clinicId,
      "userId": userId,
      "doctorId": doctorId,
      "date": date,
      "time": time,
      "serialNumber": serialNumber
    });
    return response.statusCode!;
  }

  Future<int> payBooking(String bookingId) async {
    final response = await _dio.patch('/bookings/$bookingId/pay');
    return response.statusCode!;
  }
}
