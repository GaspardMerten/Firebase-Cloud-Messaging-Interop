@JS()

/// Interop for the FCM js api.
library main;

import 'package:js/js.dart';

@JS()
external Firebase get firebase;

@JS()
class Firebase {
  external Firebase();

  external Messaging messaging();
}

typedef FnStr = Function(String str);
typedef FnCallback = Function(Function callBack);
typedef FnCallbackMessage = Function(Function(dynamic data) callBack);
typedef FnReturningPromise<T> = Promise<T> Function([dynamic arg]);

@JS()
class Messaging {
  external FnStr get usePublicVapidKey;

  external FnReturningPromise<String> get getToken;

  external FnReturningPromise<bool> get deleteToken;

  external FnCallback get onTokenRefresh;

  external FnCallbackMessage get onMessage;
}

@JS()
class Promise<T> {
  external Promise(void executor(void resolve(T result), Function reject));

  external Promise<T> then(void onFulfilled(T result), [Function onRejected]);
}

@anonymous
@JS()
class Message {
  external Notification get notification;
}

@anonymous
@JS()
class Notification {
  external String get title;

  external String get body;

  external String get tag;
}
