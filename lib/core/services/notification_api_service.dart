import 'package:clinics/core/api/dio_client.dart';
import 'package:clinics/core/config/api_route.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationApiService {
  /// Update user's FCM token
  Future<bool> updateFcmToken(String clinicId, String fcmToken) async {
    try {
      final Response response = await DioClient.instance.patch(
        '${ApiRoute.clinics}/$clinicId/fcm-token',
        data: {
          'fcmToken': fcmToken,
        },
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      print('Error updating FCM token: $e');
      return false;
    } catch (e) {
      print('Unexpected error updating FCM token: $e');
      return false;
    }
  }

  /// Notify users by doctor
  Future<int> notifyByDoctor(String doctorId, {String? message}) async {
    try {
      final Response response = await DioClient.instance.post(
        '/bookings/notify-by-doctor',
        data: {
          'doctorId': doctorId,
          if (message != null) 'message': message,
        },
      );
      print(response.statusCode);
      return response.statusCode ?? 500;
    } on DioException catch (e) {
      print('Error sending doctor notification: $e');
      return e.response?.statusCode ?? 500;
    } catch (e) {
      print('Unexpected error sending doctor notification: $e');
      return 500;
    }
  }
}
