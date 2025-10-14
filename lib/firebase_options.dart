// File manually fixed for web + android + windows
// ignore_for_file: type=lint

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web; // ✅ now returns correct web config
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError('DefaultFirebaseOptions not configured for iOS');
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions not configured for macOS',
        );
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions not configured for Linux',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // ✅ Web Firebase configuration (copied from your Firebase Console)
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyC1XNIgjHWINV44521HXp6UfzeGfkVxug8",
    authDomain: "clinic-booking-app-a6f1b.firebaseapp.com",
    projectId: "clinic-booking-app-a6f1b",
    storageBucket: "clinic-booking-app-a6f1b.firebasestorage.app",
    messagingSenderId: "845708086002",
    appId: "1:845708086002:web:6c44990caae15783021e6b",
  );

  // ✅ Android configuration (already in your file)
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOIX-HNKe_hikHQ4j0DHQAYwjxngaXT6U',
    appId: '1:845708086002:android:9696cf8e49bad939021e6b',
    messagingSenderId: '845708086002',
    projectId: 'clinic-booking-app-a6f1b',
    storageBucket: 'clinic-booking-app-a6f1b.firebasestorage.app',
  );

  // ✅ Windows (optional, just keeping it since it was in your file)
  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC1XNIgjHWINV44521HXp6UfzeGfkVxug8',
    appId: '1:845708086002:web:6c44990caae15783021e6b',
    messagingSenderId: '845708086002',
    projectId: 'clinic-booking-app-a6f1b',
    authDomain: 'clinic-booking-app-a6f1b.firebaseapp.com',
    storageBucket: 'clinic-booking-app-a6f1b.firebasestorage.app',
  );
}
