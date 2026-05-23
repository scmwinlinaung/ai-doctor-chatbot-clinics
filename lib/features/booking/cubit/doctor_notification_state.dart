abstract class DoctorNotificationState {
  const DoctorNotificationState();
}

class DoctorNotificationInitial extends DoctorNotificationState {
  const DoctorNotificationInitial();
}

class DoctorNotificationLoading extends DoctorNotificationState {
  const DoctorNotificationLoading();
}

class DoctorNotificationSuccess extends DoctorNotificationState {
  const DoctorNotificationSuccess();
}

class DoctorNotificationError extends DoctorNotificationState {
  final String message;
  const DoctorNotificationError(this.message);
}
