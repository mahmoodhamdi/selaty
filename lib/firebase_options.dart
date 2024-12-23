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
    apiKey: 'AIzaSyDddS0jQqIOXZy3bohA05SDLVExIF4kXCE',
    appId: '1:775986245859:web:682907a5bd299b163d55d6',
    messagingSenderId: '775986245859',
    projectId: 'selaty-5465',
    authDomain: 'selaty-5465.firebaseapp.com',
    storageBucket: 'selaty-5465.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCsfRID7tFVqDjFXzzuYo_9iHAx2OHg-yg',
    appId: '1:775986245859:android:ed5a1f87ef9867ee3d55d6',
    messagingSenderId: '775986245859',
    projectId: 'selaty-5465',
    storageBucket: 'selaty-5465.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCor9RU9BOwWl7Imddg_UmZFLXsTzrDf8o',
    appId: '1:775986245859:ios:8d731e990c3ca7cb3d55d6',
    messagingSenderId: '775986245859',
    projectId: 'selaty-5465',
    storageBucket: 'selaty-5465.appspot.com',
    iosBundleId: 'com.example.selaty',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCor9RU9BOwWl7Imddg_UmZFLXsTzrDf8o',
    appId: '1:775986245859:ios:8d731e990c3ca7cb3d55d6',
    messagingSenderId: '775986245859',
    projectId: 'selaty-5465',
    storageBucket: 'selaty-5465.appspot.com',
    iosBundleId: 'com.example.selaty',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDddS0jQqIOXZy3bohA05SDLVExIF4kXCE',
    appId: '1:775986245859:web:3e08b55ec72be7623d55d6',
    messagingSenderId: '775986245859',
    projectId: 'selaty-5465',
    authDomain: 'selaty-5465.firebaseapp.com',
    storageBucket: 'selaty-5465.appspot.com',
  );
}
