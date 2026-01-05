import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  String? _fcmToken;

  bool get isInitialized => _isInitialized;
  String? get fcmToken => _fcmToken;

  /// Initialize Firebase Core and FCM
  /// Set [requestPermission] to false if you want to request permission later
  Future<void> initialize({bool requestPermission = false}) async {
    if (_isInitialized) {
      debugPrint("Early return: Already initialized");
      return;
    }

    try {
      debugPrint("Firebase Core initialized successfully");

      debugPrint("About to initialize local notifications...");
      // Initialize local notifications (for Android foreground notifications)
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/launcher_icon');

      const DarwinInitializationSettings initializationSettingsDarwin =
          DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
      );

      await _localNotifications.initialize(initializationSettings);
      debugPrint("Local notifications initialized successfully");

      // Request notification permission only if requested
      debugPrint("requestPermission: $requestPermission");
      if (requestPermission) {
        await _requestPermission();
      }

      // Get initial message if app was opened from notification
      RemoteMessage? initialMessage =
          await _firebaseMessaging.getInitialMessage();

      if (initialMessage != null) {
        _handleMessage(initialMessage);
      }

      // Handle messages when app is in foreground
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // Handle messages when app is in background but opened
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

      // Listen to token refresh
      _firebaseMessaging.onTokenRefresh.listen((token) {
        _fcmToken = token;
        if (kDebugMode) {
          print('FCM Token refreshed: $token');
        }
      });

      _isInitialized = true;
      debugPrint("NotificationService initialization completed successfully!");
    } catch (e) {
      debugPrint('Error initializing notifications ERROR: $e');
      // Mark as initialized anyway for local notifications
      _isInitialized = true;
      debugPrint(
          'NotificationService initialized in degraded mode (FCM may not work)');
    }
  }

  Future<String?> getFcmToken() async {
    if (!_isInitialized) {
      await initialize();
    }
    return await _firebaseMessaging.getToken();
  }

  /// Request notification permission
  Future<NotificationSettings> _requestPermission() async {
    NotificationSettings settings;

    // For iOS, we need to request permission through Firebase Messaging
    if (Platform.isIOS) {
      settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (kDebugMode) {
        print('Authorization Status: ${settings.authorizationStatus}');
      }

      // Also request from UNUserNotificationCenter as fallback
      await _firebaseMessaging.setAutoInitEnabled(true);
    } else {
      // For Android and other platforms
      settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (kDebugMode) {
        print('========================================');
        print('Permission request completed!');
        print('Authorization Status: ${settings.authorizationStatus}');
        print('========================================');
      }

      // For Android 13+, we need to request POST_NOTIFICATIONS permission
      final androidStatus = await Permission.notification.request();
      if (kDebugMode) {
        print('Android permission status: $androidStatus');
      }
    }

    return settings;
  }

  /// Public method to request notification permission
  /// Call this from your UI when appropriate (e.g., after user onboarding)
  Future<NotificationSettings> requestNotificationPermission() async {
    return await _requestPermission();
  }

  /// Get current notification permission status without requesting
  Future<NotificationSettings> getPermissionStatus() async {
    final settings = await _firebaseMessaging.getNotificationSettings();
    if (kDebugMode) {
      print('Current permission status: ${settings.authorizationStatus}');
    }
    return settings;
  }

  /// Handle foreground messages
  void _handleForegroundMessage(RemoteMessage message) {
    if (kDebugMode) {
      print('Handling foreground message: ${message.messageId}');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
    }

    // Show local notification for Android when app is in foreground
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'com.HealthGuideClinic',
            'Health Guide Notifications',
            channelDescription: 'Notifications from Health Guide',
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/launcher_icon',
          ),
          iOS: DarwinNotificationDetails(),
        ),
        payload: message.data.toString(),
      );
    }
  }

  /// Handle messages when app is opened from notification
  void _handleMessage(RemoteMessage message) {
    if (kDebugMode) {
      print('Handling message: ${message.messageId}');
      print('Message data: ${message.data}');
    }

    // Example:
    // final String? screen = message.data['screen'];
    // if (screen != null) {
    //   navigateToScreen(screen);
    // }
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      if (kDebugMode) {
        print('Subscribed to topic: $topic');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error subscribing to topic: $e');
      }
    }
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      if (kDebugMode) {
        print('Unsubscribed from topic: $topic');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error unsubscribing from topic: $e');
      }
    }
  }

  /// Delete FCM token (useful for logout)
  Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
      _fcmToken = null;
      if (kDebugMode) {
        print('FCM token deleted');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting FCM token: $e');
      }
    }
  }
}
