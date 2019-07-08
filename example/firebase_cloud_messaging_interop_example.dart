import 'package:firebase_cloud_messaging_interop/firebase_cloud_messaging_interop.dart';
import 'dart:html';

class FCMService {
  FCM fcm;

  String currentToken;

  FCMService() {
    fcm = FCM(publicVapidKey: "YourPublicVapidKey");

    fcm.onMessage((e) {
      /// You can access title, body and tag
    });

    fcm.onTokenRefresh(requestPermissionAndGetToken);
  }

  void requestPermissionAndGetToken() {
    Notification.requestPermission().then((permission) {
      if (permission == 'granted') {
        fcm.getToken().then((e) {
          currentToken = e;

          /// SEND TOKEN TO THE BACKEND SERVER
        });
      } else {
        /// The user doesn't want notification :(
      }
    });
  }

  void deleteCurrentToken() => fcm.deleteToken(currentToken);
}
