// Import the Firebase scripts needed
importScripts(
  "https://www.gstatic.com/firebasejs/9.23.0/firebase-app-compat.js"
);
importScripts(
  "https://www.gstatic.com/firebasejs/9.23.0/firebase-messaging-compat.js"
);

// Initialize Firebase inside the service worker
firebase.initializeApp({
  apiKey: "AIzaSyCQ9cOxrvlZZA6id6bUAlKksQcT0NIaarc",
  authDomain: "navi-care-b7a15.firebaseapp.com",
  projectId: "navi-care-b7a15",
  storageBucket: "navi-care-b7a15.firebasestorage.app",
  messagingSenderId: "536465457827",
  appId: "1:536465457827:web:c7f70d761fa943d2adb516",
});

const messaging = firebase.messaging();
