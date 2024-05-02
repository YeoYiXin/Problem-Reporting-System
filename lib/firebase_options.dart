// // Written by Grp B
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBK8yLJkRtukow-9xr60aaMUh7BWz4VNNM',
    appId: '1:935607970977:web:70ed606a35eec5cc4a94e0',
    messagingSenderId: '935607970977',
    projectId: 'nott-a-problem',
    authDomain: 'nott-a-problem.firebaseapp.com',
    storageBucket: 'nott-a-problem.appspot.com',
    measurementId: 'G-KFMPTTR8YY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDi_owE2tZpGTbN7OI8HJKXWdu7z02bnlc',
    appId: '1:935607970977:android:99b3e07437b183734a94e0',
    messagingSenderId: '935607970977',
    projectId: 'nott-a-problem',
    storageBucket: 'nott-a-problem.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBsAiR6ak0o4v47QEP7xzsiqCQMSXEZ9lc',
    appId: '1:935607970977:ios:99203acb3a5dc4514a94e0',
    messagingSenderId: '935607970977',
    projectId: 'nott-a-problem',
    storageBucket: 'nott-a-problem.appspot.com',
    iosBundleId: 'com.example.problemReportingSystem',
  );
}
