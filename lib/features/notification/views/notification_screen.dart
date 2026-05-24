import 'package:clinics/core/config/app_colors.dart';
import 'package:clinics/features/notification/cubit/clinic_notification_cubit.dart';
import 'package:clinics/features/notification/cubit/clinic_notification_state.dart';
import 'package:clinics/features/notification/models/clinic_notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ClinicNotificationCubit>().fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: BlocBuilder<ClinicNotificationCubit, ClinicNotificationState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (notifications) => notifications.isEmpty
                ? _buildEmptyState()
                : _buildNotificationList(notifications),
            error: (message) => _buildErrorState(message),
          );
        },
      ),
    );
  }

  Widget _buildNotificationList(List<ClinicNotificationModel> notifications) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return InkWell(
          onTap: () {
            if (notification.id != null && notification.isRead != true) {
              context.read<ClinicNotificationCubit>().markAsRead(notification.id!);
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: _buildNotificationCard(notification),
        );
      },
    );
  }

  Widget _buildNotificationCard(ClinicNotificationModel notification) {
    final DateTime? createdAt = notification.createdAt != null
        ? DateTime.tryParse(notification.createdAt!)
        : null;
    final bool isUnread = notification.isRead == false;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isUnread 
                ? AppColors.primaryColor.withOpacity(0.08)
                : Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: isUnread ? AppColors.primaryColor : Colors.transparent,
                width: 4,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isUnread
                        ? AppColors.primaryColor.withOpacity(0.1)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    _getIconForType(notification.type),
                    color: isUnread ? AppColors.primaryColor : Colors.grey[400],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              _formatType(notification.type),
                              style: TextStyle(
                                fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                                fontSize: 16,
                                color: AppColors.lightPrimaryText,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                          if (createdAt != null)
                            Text(
                              _getRelativeTime(createdAt),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notification.message ?? 'No Message',
                        style: TextStyle(
                          fontSize: 14,
                          color: isUnread 
                              ? AppColors.lightPrimaryText.withOpacity(0.8)
                              : AppColors.lightSecondaryText,
                          height: 1.4,
                        ),
                      ),
                      if (isUnread) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'NEW',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getRelativeTime(DateTime dateTime) {
    final duration = DateTime.now().difference(dateTime);
    if (duration.inMinutes < 1) return 'now';
    if (duration.inMinutes < 60) return '${duration.inMinutes}m';
    if (duration.inHours < 24) return '${duration.inHours}h';
    if (duration.inDays < 7) return '${duration.inDays}d';
    return DateFormat('MMM d').format(dateTime);
  }

  String _formatType(String? type) {
    if (type == null || type.isEmpty) return 'Notification';
    return type
        .split('_')
        .map((word) => word.isEmpty
            ? ''
            : '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  IconData _getIconForType(String? type) {
    switch (type) {
      case 'new_booking':
        return Icons.calendar_today_outlined;
      case 'cancelled_booking':
        return Icons.event_busy_outlined;
      case 'subscription_update':
        return Icons.card_membership_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text(
            'No notifications yet',
            style: TextStyle(color: AppColors.lightSecondaryText, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  context.read<ClinicNotificationCubit>().fetchNotifications(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
