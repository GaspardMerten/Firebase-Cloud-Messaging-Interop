import 'package:firebase_cloud_messaging_interop/firebase_cloud_messaging_interop.dart';

class NotificationService {
  NotificationService() {
    // Direct init
    fcm = FirebaseMessagingWeb(publicVapidKey: 'YourPublicVapidKey');

    // Deferred init
    fcm = FirebaseMessagingWeb();
    fcm.init('YourPublicVapidKey');

    /// Setup callback for whenever a notification is received.
    /// The app must be open inside the navigator for this callback to fire.
    fcm.onMessage((Map notificationData) {
      // do something with notification data
    });

    /// Whenever the token is refreshed,
    fcm.onTokenRefresh(() async {
      final String token = await fcm.getToken();

      // push token to server
    });
  }

  FirebaseMessagingWeb fcm;

  String currentToken;

  /// Ask user for permission
  Future<bool> getPermission() => fcm.requestNotificationPermissions();

  /// Delete current user token
  void deleteCurrentToken() => fcm.deleteToken(currentToken);
}
