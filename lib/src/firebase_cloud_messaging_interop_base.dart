@JS()
library main;

import 'dart:async';

import 'package:js/js.dart';

Future futureFromPromise(Promise<String> p) {
  final completer = Completer<String>();
  p.then(allowInterop(completer.complete),
      allowInterop(completer.completeError));
  return completer.future;
}

@JS()
external Firebase get firebase;

@JS()
class Firebase {
  external Firebase();
  external Messaging messaging();
}


@JS()
class Messaging {
  @JS("usePublicVapidKey")
  external FirebaseFnStr get usePublicVapidKey;

  @JS("getToken")
  external Promise<String> getToken();
}

@JS()
class Promise<T> {
  external Promise(void executor(void resolve(T result), Function reject));
  external Promise then(void onFulfilled(T result), [Function onRejected]);
}

typedef FirebaseFnStr = Function(String str);
typedef Promise FnReturningPromise();