import 'package:clinics/core/api/dio_client.dart';
import 'package:clinics/features/booking/model/clinic_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClinicService {
  final Dio _dio = DioClient.instance;

  Future<ClinicModel> getAClinicByID(String id) async {
    final response = await _dio.get('/clinics/$id');
    return ClinicModel.fromJson(response.data);
  }
}
