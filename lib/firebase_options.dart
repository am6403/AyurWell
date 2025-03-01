// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCtVnhzDYL6crxgmM14rXS6GCTvRXDdicQ',
    appId: '1:294486161346:web:faedddf848a783864ac85b',
    messagingSenderId: '294486161346',
    projectId: 'prakritipath-83f3c',
    authDomain: 'prakritipath-83f3c.firebaseapp.com',
    storageBucket: 'prakritipath-83f3c.appspot.com',
    measurementId: 'G-QRJC7PYNL5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCVb8YIqELxMspHvaddFnlF3OqVflDJEkk',
    appId: '1:294486161346:android:ed133a35e76c44b94ac85b',
    messagingSenderId: '294486161346',
    projectId: 'prakritipath-83f3c',
    storageBucket: 'prakritipath-83f3c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7ZSi_82yehGDMYA_dqqUpHTNRBQWbRhM',
    appId: '1:294486161346:ios:15702391e294e2ae4ac85b',
    messagingSenderId: '294486161346',
    projectId: 'prakritipath-83f3c',
    storageBucket: 'prakritipath-83f3c.appspot.com',
    iosBundleId: 'com.example.prakritiFinder',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC7ZSi_82yehGDMYA_dqqUpHTNRBQWbRhM',
    appId: '1:294486161346:ios:15702391e294e2ae4ac85b',
    messagingSenderId: '294486161346',
    projectId: 'prakritipath-83f3c',
    storageBucket: 'prakritipath-83f3c.appspot.com',
    iosBundleId: 'com.example.prakritiFinder',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCtVnhzDYL6crxgmM14rXS6GCTvRXDdicQ',
    appId: '1:294486161346:web:58b942736e9411e14ac85b',
    messagingSenderId: '294486161346',
    projectId: 'prakritipath-83f3c',
    authDomain: 'prakritipath-83f3c.firebaseapp.com',
    storageBucket: 'prakritipath-83f3c.appspot.com',
    measurementId: 'G-FXEG5Z1LLR',
  );
}
