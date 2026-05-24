import 'dart:async';
import 'package:clinics/core/services/notification_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'clinic_notification_state.dart';

@lazySingleton
class ClinicNotificationCubit extends Cubit<ClinicNotificationState> {
  final NotificationApiService _notificationApiService;
  Timer? _pollingTimer;

  ClinicNotificationCubit(this._notificationApiService)
      : super(const ClinicNotificationState.initial());

  void startPolling() {
    _pollingTimer?.cancel();
    fetchNotifications();
    _pollingTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      fetchNotifications(isPolling: true);
    });
  }

  Future<void> fetchNotifications({bool isPolling = false}) async {
    try {
      if (!isPolling) {
        emit(const ClinicNotificationState.loading());
      }
      final notifications = await _notificationApiService.getClinicNotifications();
      emit(ClinicNotificationState.loaded(notifications));
    } catch (e) {
      if (!isPolling) {
        emit(ClinicNotificationState.error(e.toString()));
      }
    }
  }

  Future<void> markAsRead(String id) async {
    state.maybeMap(
      loaded: (loadedState) async {
        // Optimistically update the UI
        final updatedNotifications = loadedState.notifications.map((n) {
          if (n.id == id) {
            return n.copyWith(isRead: true);
          }
          return n;
        }).toList();

        emit(ClinicNotificationState.loaded(updatedNotifications));

        // Update on server
        await _notificationApiService.markAsRead(id);
      },
      orElse: () {},
    );
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }
}
