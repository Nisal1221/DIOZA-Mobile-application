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
    apiKey: 'AIzaSyDxx7qJCQ4HyfoFV-BcWC-Pmwd3EX5eQDw',
    appId: '1:530365582094:web:15cb008e71b84eb630255f',
    messagingSenderId: '530365582094',
    projectId: 'dioza-new',
    authDomain: 'dioza-new.firebaseapp.com',
    databaseURL: 'https://dioza-new-default-rtdb.firebaseio.com',
    storageBucket: 'dioza-new.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkE8KTaC7aAayI1eZf_wqOTMZoYpWukvs',
    appId: '1:530365582094:android:8fd1b1dcd3215e2f30255f',
    messagingSenderId: '530365582094',
    projectId: 'dioza-new',
    databaseURL: 'https://dioza-new-default-rtdb.firebaseio.com',
    storageBucket: 'dioza-new.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAaVPX8Qgr8wxlaAaLKjhdjT9G3vlhWXk0',
    appId: '1:530365582094:ios:f2ea5be366bf205930255f',
    messagingSenderId: '530365582094',
    projectId: 'dioza-new',
    databaseURL: 'https://dioza-new-default-rtdb.firebaseio.com',
    storageBucket: 'dioza-new.appspot.com',
    androidClientId: '530365582094-3iaaobka4fe6deosviri4uhnssrfghsh.apps.googleusercontent.com',
    iosClientId: '530365582094-ap4e5su890rf0aspb2fdd881bq9rh5oe.apps.googleusercontent.com',
    iosBundleId: 'com.example.untitled2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAaVPX8Qgr8wxlaAaLKjhdjT9G3vlhWXk0',
    appId: '1:530365582094:ios:f2ea5be366bf205930255f',
    messagingSenderId: '530365582094',
    projectId: 'dioza-new',
    databaseURL: 'https://dioza-new-default-rtdb.firebaseio.com',
    storageBucket: 'dioza-new.appspot.com',
    androidClientId: '530365582094-3iaaobka4fe6deosviri4uhnssrfghsh.apps.googleusercontent.com',
    iosClientId: '530365582094-ap4e5su890rf0aspb2fdd881bq9rh5oe.apps.googleusercontent.com',
    iosBundleId: 'com.example.untitled2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDxx7qJCQ4HyfoFV-BcWC-Pmwd3EX5eQDw',
    appId: '1:530365582094:web:56b85525a510b6d630255f',
    messagingSenderId: '530365582094',
    projectId: 'dioza-new',
    authDomain: 'dioza-new.firebaseapp.com',
    databaseURL: 'https://dioza-new-default-rtdb.firebaseio.com',
    storageBucket: 'dioza-new.appspot.com',
  );
}
