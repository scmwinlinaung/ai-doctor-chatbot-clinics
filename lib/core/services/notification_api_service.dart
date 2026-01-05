import 'package:clinics/core/api/dio_client.dart';
import 'package:dio/dio.dart';

class NotificationApiService {
  /// Update user's FCM token
  Future<bool> updateFcmToken(String clinicId, String fcmToken) async {
    try {
      final Response response = await DioClient.instance.patch(
        '/clinics/$clinicId/fcm-token',
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
}
