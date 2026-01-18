import Flutter
import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()

    // Set UNUserNotificationCenterDelegate
    UNUserNotificationCenter.current().delegate = self

    // Set up messaging delegate
    Messaging.messaging().delegate = self

    // Register for remote notifications - this triggers APNS token request
    application.registerForRemoteNotifications()

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate {
  // Handle notification when app is in foreground
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    let userInfo: [AnyHashable: Any] = notification.request.content.userInfo
    NSLog("[PushNotification] App is foreground. Notification payload: %@", userInfo)

    // Show notification banner/alert/sound when app is in foreground
    if #available(iOS 14.0, *) {
      completionHandler([[.banner, .sound, .list]])
    } else {
      completionHandler([[.alert, .sound]])
    }
  }

  // Handle notification tap when app is in background or terminated
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    let userInfo: [AnyHashable: Any] = response.notification.request.content.userInfo
    NSLog("[PushNotification] Notification tapped. Payload: %@", userInfo)

    completionHandler()
  }
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
  // This callback is fired when FCM tokens are refreshed
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    NSLog("[PushNotification] FCM token received: %@", fcmToken ?? "nil")

    if let fcmToken = fcmToken {
      // Send token to your server or store it
      NSLog("[PushNotification] FCM token: %@", fcmToken)
    }
  }

  // This is called when APNS token is received
  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Messaging.messaging().apnsToken = deviceToken
    NSLog("[PushNotification] APNS token registered successfully")
  }

  // This is called when APNS registration fails
  override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    NSLog("[PushNotification] Failed to register for remote notifications: %@", error.localizedDescription)
  }
}
