# Firebase Messaging Plugin for Flutter (web)/Angular dart

A dart plugin to use the [Firebase Cloud Messaging API](https://firebase.google.com/docs/cloud-messaging). Only works for Flutter web and Angular dart. 

For Android/iOS consider using this [plugin](https://pub.dev/packages/firebase_messaging). (Note that both plugins can coexist!).

To learn more about Firebase Cloud Messaging, please visit the [Firebase website](https://firebase.google.com/products/cloud-messaging)

[![pub package](https://img.shields.io/pub/v/firebase_cloud_messaging_interop.svg)](https://pub.dev/packages/firebase_cloud_messaging_interop)

## Getting Started

To get started with Firebase Cloud Messaging for Flutter Web/Angular Dart, please follow these steps:

#### Step 1 

Add the gcm_sender_id to the manifest.json  <i>(your_project/web/manifest.json)</i>
```json
{
  ...
  "gcm_sender_id": "SENDER_ID",
  ...
}
```
Make sure that you find this line inside the head tag of the index.html file <i>(your_project/web/index.html)</i>
```html
<link rel="manifest" href="/manifest.json">
```

#### Step 2

Add the firebase-app and firebase-messaging js libraries to your project (inside the head tag)

```html
    <!-- Make sure that 8.1.1 is still supported (latest check 11/22/2020) -->
    <script src="https://www.gstatic.com/firebasejs/8.1.1/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.1.1/firebase-messaging.js"></script> 
```

Then init the default firebase app (just below the previous lines).

If you want to defer the initialization of the firebase app, please refer to the previously mentioned link.

```html
    <script>
        let firebaseConfig = {
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
```

#### Step 3

This last step will allow your browser to receive a notification while your app is running in the background/closed.

Start by creating a file named 'firebase-messaging-sw.js' (your_project/web/firebase-messaging-sw.js).

Then insert the following lines.

```js
importScripts('https://www.gstatic.com/firebasejs/8.1.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.1.1/firebase-messaging.js');

// Initialize the Firebase app in the service worker by passing in the
// messagingSenderId.
firebase.initializeApp({
   apiKey: "your-api-key",
   authDomain: "PROJECT_NAME.firebaseapp.com",
   databaseURL: "https://PROJECT_NAME.firebaseio.com", 
   projectId: "PROJECT_NAME",
   storageBucket: "PROJECT_NAME.appspot.com",
   messagingSenderId: "MESSAGING_SENDER_ID",
   appId: "APP_ID"
});

// Retrieve an instance of Firebase Messaging so that it can handle background
// messages.
const messaging = firebase.messaging();
```


## Usage

This plugin provides you with the following class and methods:

- FirebaseMessagingWeb (the interface between you and the interop, way more coder friendly).


```dart
/// Direct init
final FirebaseMessagingWeb fcm = FirebaseMessagingWeb(publicVapidKey: "yourPublicVapidKey"); 
```

```dart
/// Deferred init
final FirebaseMessagingWeb fcm = FirebaseMessagingWeb();

// Do some stuff

fcm.init("yourPublicVapidKey")
```

- FirebaseMessagingWeb.requestNotificationPermissions

```dart
final bool didGivePermissions = await fcm.requestNotificationPermissions();

if (didGivePermissions) {
 // Retrieve token
}
```

- FirebaseMessagingWeb.getToken

```dart
final String token = await fcm.getToken();

// post token to your server
```


- FirebaseMessagingWeb.onTokenRefresh

```dart
fcm.onTokenRefresh(() {
  // get new token
});
```


- FirebaseMessagingWeb.onMessage

```dart
fcm.onMessage((Map messagePayload) {
  // do something with message data
});
```

<b>Important note: </b> You can't directly subscribe to a topic with this plugin. You will need to make a call
to Firebase from your server with the user token to do so.

## License

Apache License 2.0 [(link)]

[(link)]: https://github.com/GaspardMerten/Firebase-Cloud-Messaging-Interop/blob/master/LICENSE

## Issues & Feedback

Please send feature requests, bugs and feedback to my mail address!
