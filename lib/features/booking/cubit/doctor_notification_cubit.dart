import 'package:clinics/core/services/notification_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'doctor_notification_state.dart';

@injectable
class DoctorNotificationCubit extends Cubit<DoctorNotificationState> {
  final NotificationApiService _notificationApiService;

  DoctorNotificationCubit(this._notificationApiService)
      : super(const DoctorNotificationInitial());

  Future<void> notifyByDoctor(String doctorId, {String? message}) async {
    try {
      emit(const DoctorNotificationLoading());
      final statusCode =
          await _notificationApiService.notifyByDoctor(doctorId, message: message);
      if (statusCode == 200 || statusCode == 201) {
        emit(const DoctorNotificationSuccess());
      } else {
        emit(const DoctorNotificationError('Failed to send notification'));
      }
    } catch (e) {
      emit(DoctorNotificationError(e.toString()));
    }
  }
}
