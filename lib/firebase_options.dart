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
    apiKey: 'AIzaSyDFO4tq6sgYDI6gTXR6-DM0DEmhBdBS0dA',
    appId: '1:116551013929:web:3561c972c48fb60d962e38',
    messagingSenderId: '116551013929',
    projectId: 'staffverify-mobile',
    authDomain: 'staffverify-mobile.firebaseapp.com',
    storageBucket: 'staffverify-mobile.firebasestorage.app',
    measurementId: 'G-8H2GY9FXMW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBg13AiYDjs3Wp95BTR9olH628tGWtQ7Bo',
    appId: '1:116551013929:android:5f3d8ae2a724c243962e38',
    messagingSenderId: '116551013929',
    projectId: 'staffverify-mobile',
    storageBucket: 'staffverify-mobile.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyATFyp-vZPAescuI-O7Zv1ZxWeebXn2woo',
    appId: '1:116551013929:ios:4afa75211601cb2c962e38',
    messagingSenderId: '116551013929',
    projectId: 'staffverify-mobile',
    storageBucket: 'staffverify-mobile.firebasestorage.app',
    iosBundleId: 'com.example.staffVerify',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyATFyp-vZPAescuI-O7Zv1ZxWeebXn2woo',
    appId: '1:116551013929:ios:4afa75211601cb2c962e38',
    messagingSenderId: '116551013929',
    projectId: 'staffverify-mobile',
    storageBucket: 'staffverify-mobile.firebasestorage.app',
    iosBundleId: 'com.example.staffVerify',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDFO4tq6sgYDI6gTXR6-DM0DEmhBdBS0dA',
    appId: '1:116551013929:web:651bdc030074a848962e38',
    messagingSenderId: '116551013929',
    projectId: 'staffverify-mobile',
    authDomain: 'staffverify-mobile.firebaseapp.com',
    storageBucket: 'staffverify-mobile.firebasestorage.app',
    measurementId: 'G-LSPET4NDGB',
  );
}
