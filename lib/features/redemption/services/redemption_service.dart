import 'package:clinics/core/api/dio_client.dart';
import 'package:clinics/features/redemption/models/redemption_request_model.dart';
import 'package:clinics/features/redemption/models/redemption_response_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class RedemptionService {
  final Dio _dio = DioClient.instance;

  Future<RedemptionResponseModel> verifyRedemptionCode(
      RedemptionRequestModel request) async {
    try {
      final response = await _dio.post(
        '/redemptions/verify',
        data: request.toJson(),
      );
      return RedemptionResponseModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception(
            'Invalid or already used code / Reward or user not found');
      } else if (e.response?.statusCode == 403) {
        throw Exception('Forbidden (Admin access required)');
      } else if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      } else {
        throw Exception('Server Error: ${e.message}');
      }
    }
  }
}
