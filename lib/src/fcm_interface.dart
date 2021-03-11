import 'dart:convert';
import 'dart:html' as html;
import 'dart:js';

import 'package:firebase_cloud_messaging_interop/src/fcm_interop.dart';
import 'package:firebase_cloud_messaging_interop/src/js_to_dart_helper.dart';
import 'package:firebase_cloud_messaging_interop/src/stringify_interop.dart';

/// An interface that make it easier to use FCM interop.
class FirebaseMessagingWeb {
  /// If the [publicVapidKey] is specified, the init function will be call in
  /// the constructor. If not, then the init method should be called before using
  /// any other function related to [FCM]
  FirebaseMessagingWeb({String? publicVapidKey}) {
    if (publicVapidKey != null) {
      init(publicVapidKey);
    }
  }

  late Messaging _messaging;

  /// Initiates Firebase Messaging and set the [publicVapidKey].
  void init(String publicVapidKey) {
    if (publicVapidKey.isEmpty) {
      throw const FormatException(
          'The publicVapidKey can not be null nor can it be an empty string !');
    }

    _messaging = firebase.messaging();

    _messaging.usePublicVapidKey(publicVapidKey);
  }

  /// Adds a callback allowing to retrieve the new token after it was refreshed.
  void onTokenRefresh(Function() callBack) =>
      _messaging.onTokenRefresh(allowInterop(() => callBack()));

  /// Adds a callback allowing to retrieve the FCM payload
  void onMessage(Function(Map<String, dynamic>? message) callBack) {
    _messaging.onMessage(allowInterop((dynamic jsMessageObject) {
      return callBack(
          jsonDecode(stringify(jsMessageObject)) as Map<String, dynamic>?);
    }));
  }

  /// Prompts the user for notification permissions the first time
  Future<bool> requestNotificationPermissions() async {
    final String result = await html.Notification.requestPermission();

    return result == 'granted';
  }

  /// Deletes the current FCM token.
  Future<bool> deleteToken(String? token) =>
      futureFromPromise<bool>(_messaging.deleteToken(token));

  /// Retrieves the client FCM token. (The client must first ask for the permission [requestNotificationPermissions])
  Future<String> getToken() => futureFromPromise<String>(_messaging.getToken());
}
