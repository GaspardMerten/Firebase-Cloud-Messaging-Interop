import 'package:firebase_cloud_messaging_interop/firebase_cloud_messaging_interop.dart';
import 'dart:html';

main() {
  Messaging messaging = firebase.messaging();

  messaging.usePublicVapidKey("YOUR_VAPID_KEY");

  /// Ask for permission to send notification
  Notification.requestPermission().then((permission) {
    if (permission == 'granted') {
      futureFromPromise(messaging.getToken().then((e) {
        /// SEND TOKEN TO THE BACKEND SERVER
      }));
    }
    else {
      /// User doesn't want notification :(
    }
  });
}
