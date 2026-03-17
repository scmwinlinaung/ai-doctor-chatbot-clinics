import 'package:flutter/material.dart';

/// A badge widget that indicates whether a booking is read or unread
class ReadStatusBadge extends StatelessWidget {
  final bool isRead;

  const ReadStatusBadge({
    super.key,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    if (isRead) {
      // Show "Read" badge for read bookings
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.green.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 12,
              color: Colors.green,
            ),
            SizedBox(width: 4),
            Text(
              'Read',
              style: TextStyle(
                color: Colors.green,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    // Show "Unread" badge for unread bookings
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.mark_email_unread_outlined,
            size: 12,
            color: Colors.blue,
          ),
          SizedBox(width: 4),
          Text(
            'Unread',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
