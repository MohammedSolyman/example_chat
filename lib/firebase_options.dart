// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        return macos;
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
    apiKey: 'AIzaSyCIFS_A5844v7DoTOfM6XhYuVh3rDrbguQ',
    appId: '1:938676857383:web:69b7db7c483879452b3c02',
    messagingSenderId: '938676857383',
    projectId: 'my-cli-test-3541b',
    authDomain: 'my-cli-test-3541b.firebaseapp.com',
    storageBucket: 'my-cli-test-3541b.appspot.com',
    measurementId: 'G-71Q2Z8XGN7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCYwrfUxNpk5q-CERN8v7SXsgg93xjMW1Q',
    appId: '1:938676857383:android:5c09bcaa085ed9cb2b3c02',
    messagingSenderId: '938676857383',
    projectId: 'my-cli-test-3541b',
    storageBucket: 'my-cli-test-3541b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCcRIs3FeYsWCb69TjHLdJr41bZzVOzID0',
    appId: '1:938676857383:ios:d1a460257b3476f82b3c02',
    messagingSenderId: '938676857383',
    projectId: 'my-cli-test-3541b',
    storageBucket: 'my-cli-test-3541b.appspot.com',
    iosBundleId: 'com.example.myCliTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCcRIs3FeYsWCb69TjHLdJr41bZzVOzID0',
    appId: '1:938676857383:ios:21dc63139c74833f2b3c02',
    messagingSenderId: '938676857383',
    projectId: 'my-cli-test-3541b',
    storageBucket: 'my-cli-test-3541b.appspot.com',
    iosBundleId: 'com.example.myCliTest.RunnerTests',
  );
}
