import 'dart:async';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// A widget that detects when its child becomes visible on screen
/// and triggers a callback after a specified duration.
class BookingVisibilityDetector extends StatefulWidget {
  /// The child widget to track visibility for
  final Widget child;

  /// The booking ID
  final String bookingId;

  /// Whether the booking has been read
  final bool isRead;

  /// Callback to trigger when booking becomes visible for the specified duration
  final Future<void> Function(String bookingId) onVisible;

  /// Duration to wait before marking as read (default: 2 seconds)
  final Duration visibilityThreshold;

  /// Minimum visible fraction required to start the timer (0.0 to 1.0)
  final double visibleFractionThreshold;

  const BookingVisibilityDetector({
    super.key,
    required this.child,
    required this.bookingId,
    required this.isRead,
    required this.onVisible,
    this.visibilityThreshold = const Duration(seconds: 2),
    this.visibleFractionThreshold = 0.5,
  });

  @override
  State<BookingVisibilityDetector> createState() =>
      _BookingVisibilityDetectorState();
}

class _BookingVisibilityDetectorState
    extends State<BookingVisibilityDetector> {
  Timer? _visibilityTimer;
  bool _hasBeenCalled = false;

  @override
  void didUpdateWidget(BookingVisibilityDetector oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset state when isRead changes
    if (oldWidget.isRead != widget.isRead) {
      _hasBeenCalled = false;
      _visibilityTimer?.cancel();
      _visibilityTimer = null;
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    // Don't proceed if already read or already called
    if (widget.isRead || _hasBeenCalled) {
      _visibilityTimer?.cancel();
      return;
    }

    // Check if widget is visible enough
    if (info.visibleFraction >= widget.visibleFractionThreshold) {
      // Start timer if not already running
      _visibilityTimer ??= Timer(widget.visibilityThreshold, () {
        if (mounted && !_hasBeenCalled) {
          _hasBeenCalled = true;
          widget.onVisible(widget.bookingId);
        }
      });
    } else {
      // Cancel timer if not visible enough
      _visibilityTimer?.cancel();
      _visibilityTimer = null;
    }
  }

  @override
  void dispose() {
    _visibilityTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('booking-${widget.bookingId}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: widget.child,
    );
  }
}
