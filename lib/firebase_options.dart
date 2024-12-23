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
    apiKey: 'AIzaSyB7rLggObdQ7PSraASCCkdPK6yGdG-0TQc',
    appId: '1:316005569843:web:6ab2729fd7746fe9569a46',
    messagingSenderId: '316005569843',
    projectId: 'collection-reqst',
    authDomain: 'collection-reqst.firebaseapp.com',
    storageBucket: 'collection-reqst.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBaA3LZWwrMlY67nzk855hzUo-4HY28mOg',
    appId: '1:316005569843:android:c00375108969c55c569a46',
    messagingSenderId: '316005569843',
    projectId: 'collection-reqst',
    storageBucket: 'collection-reqst.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBkcEtAsQn2O62wNM4cgpHTPfuUthOkRKE',
    appId: '1:316005569843:ios:db064d02b4261ad4569a46',
    messagingSenderId: '316005569843',
    projectId: 'collection-reqst',
    storageBucket: 'collection-reqst.firebasestorage.app',
    iosBundleId: 'com.example.connectionRqst',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBkcEtAsQn2O62wNM4cgpHTPfuUthOkRKE',
    appId: '1:316005569843:ios:db064d02b4261ad4569a46',
    messagingSenderId: '316005569843',
    projectId: 'collection-reqst',
    storageBucket: 'collection-reqst.firebasestorage.app',
    iosBundleId: 'com.example.connectionRqst',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB7rLggObdQ7PSraASCCkdPK6yGdG-0TQc',
    appId: '1:316005569843:web:4c5fe8e1bbd3639b569a46',
    messagingSenderId: '316005569843',
    projectId: 'collection-reqst',
    authDomain: 'collection-reqst.firebaseapp.com',
    storageBucket: 'collection-reqst.firebasestorage.app',
  );
}