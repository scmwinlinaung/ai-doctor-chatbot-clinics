import 'package:clinics/core/api/dio_client.dart';
import 'package:clinics/core/config/api_route.dart';
import 'package:clinics/features/reports/models/clinic_report_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReportService {
  final Dio _dio = DioClient.instance;

  Future<ClinicReportModel> getClinicReport({
    required String clinicId,
    String? fromDate,
    String? toDate,
    String? username,
  }) async {
    try {
      final response = await _dio.get(
        '${ApiRoute.reports}/clinic/$clinicId',
        queryParameters: {
          if (fromDate != null) 'fromDate': fromDate,
          if (toDate != null) 'toDate': toDate,
          if (username != null) 'username': username,
        },
      );
      return ClinicReportModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('Invalid Clinic ID format');
      } else if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      } else if (e.response?.statusCode == 403) {
        throw Exception('Forbidden (Admin access required)');
      } else {
        throw Exception('Server Error: ${e.message}');
      }
    }
  }
}
