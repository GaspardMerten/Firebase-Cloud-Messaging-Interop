import 'package:firebase_cloud_messaging_interop/src/fcm_interop.dart';
import 'package:firebase_cloud_messaging_interop/src/js_to_dart_helper.dart';

/// An interface that make it easier to use FCM interop.
class FCM {
  Messaging _messaging;

  /// If the [publicVapidKey] is specified, the init function will be call in
  /// the constructor. If not, then the init method should be called before using
  /// any other function related to [FCM]
  FCM({String publicVapidKey}) {
    if (publicVapidKey != null) init(publicVapidKey);
  }

  /// Initiate Firebase Messaging and set the [publicVapidKey].
  void init(String publicVapidKey) {
    if (publicVapidKey == null || publicVapidKey.isEmpty) {
      throw FormatException(
          "The publicVapidKey can not be null nor can it be an empty string !");
    }

    _messaging = firebase.messaging();

    _messaging.usePublicVapidKey(publicVapidKey);
  }

  /// Adding a callback allowing to retrieve the new token after it was refreshed.
  void onTokenRefresh(Function() callBack) =>
      _messaging.onTokenRefresh(callBack);

  /// Adding a callback allowing to retrieve the notification data ([Notification]).
  void onMessage(Function(Notification notification) callBack) =>
      _messaging.onMessage((Message e) => callBack((e.notification)));

  /// Delete the current FCM token.
  Future<bool> deleteToken(String token) =>
      futureFromPromise<bool>(_messaging.deleteToken(token));

  /// Retrieve the client FCM token. (The client must first ask for the permission [Notification.requestPermission])
  Future<String> getToken() => futureFromPromise<String>(_messaging.getToken());
}
