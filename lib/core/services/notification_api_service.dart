import 'package:clinics/core/api/dio_client.dart';
import 'package:clinics/core/config/api_route.dart';
import 'package:clinics/features/notification/models/clinic_notification_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationApiService {
  /// Fetch clinic notifications
  Future<List<ClinicNotificationModel>> getClinicNotifications() async {
    try {
      final Response response = await DioClient.instance.get(
        ApiRoute.clinicNotification,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((json) => ClinicNotificationModel.fromJson(json))
            .toList();
      }
      return [];
    } on DioException catch (e) {
      print('Error fetching clinic notifications: $e');
      return [];
    } catch (e) {
      print('Unexpected error fetching clinic notifications: $e');
      return [];
    }
  }

  /// Mark a notification as read
  Future<bool> markAsRead(String id) async {
    try {
      final Response response = await DioClient.instance.patch(
        '/notifications/$id/clinic-mark-as-read',
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      print('Error marking notification as read: $e');
      return false;
    } catch (e) {
      print('Unexpected error marking notification as read: $e');
      return false;
    }
  }

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
