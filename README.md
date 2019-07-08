## Introduction

An interop of the Firebase Cloud Messaging solution (JS) in dart.
- You can retrieve the client's firebase token.
- You can send push notification through Firebase.

## Setup

For more information on how to setup FCM on the web: https://firebase.google.com/docs/cloud-messaging/js/client

```json
{
  "gcm_sender_id": "SENDER_ID",
}
```

- You need to add firebase-app and firebase-messaging to your web app. 

```html
<html>
<head>
...
<script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-messaging.js"></script>

    <script>
        var firebaseConfig = {
            apiKey: "your-api-key",
            authDomain: "PROJECT_NAME.firebaseapp.com",
            databaseURL: "https://PROJECT_NAME.firebaseio.com", 
            projectId: "PROJECT_NAME",
            storageBucket: "PROJECT_NAME.appspot.com",
            messagingSenderId: "MESSAGING_SENDER_ID",
            appId: "APP_ID"
        };
        // Initialize Firebase
        firebase.initializeApp(firebaseConfig); 
    </script>
    </head>
```

- You need to create a file named 'firebase-messaging-sw.js' (Just create an empty file if you do ot want notification when your web app is closed)

```js
importScripts('https://www.gstatic.com/firebasejs/6.2.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/6.2.0/firebase-messaging.js');

// Initialize the Firebase app in the service worker by passing in the
// messagingSenderId.
firebase.initializeApp({
    'messagingSenderId': 'SENDER_ID'
});

// Retrieve an instance of Firebase Messaging so that it can handle background
// messages.
const messaging = firebase.messaging();
```

## Usage

A simple usage example:

```dart
import 'package:firebase_cloud_messaging_interop/firebase_cloud_messaging_interop.dart';

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
      /// User does'nt want notification :(
    }
  });
}
```

## License

Apache License 2.0 [(link)]

[(link)]: https://github.com/GaspardMerten/Firebase-Cloud-Messaging-Interop/blob/master/LICENSE

## Features and bugs

Please send feature requests and bugs to my mail address !

This is my first plugin so :D ... 