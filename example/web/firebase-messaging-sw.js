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