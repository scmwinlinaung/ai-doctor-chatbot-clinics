import 'package:clinics/features/notification/models/clinic_notification_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_notification_state.freezed.dart';

@freezed
class ClinicNotificationState with _$ClinicNotificationState {
  const factory ClinicNotificationState.initial() = _Initial;
  const factory ClinicNotificationState.loading() = _Loading;
  const factory ClinicNotificationState.loaded(List<ClinicNotificationModel> notifications) = _Loaded;
  const factory ClinicNotificationState.error(String message) = _Error;
}
