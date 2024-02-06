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
    apiKey: 'AIzaSyA908kp2cbLUG5r1myYLS7dKEV1xlkw5ZI',
    appId: '1:5911714952:web:6514d23b2a1582c87f933d',
    messagingSenderId: '5911714952',
    projectId: 'fir-main-8b658',
    authDomain: 'fir-main-8b658.firebaseapp.com',
    storageBucket: 'fir-main-8b658.appspot.com',
    measurementId: 'G-WD9SM5YZHN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBHLnWqz5EnAhVIuKiIeM8gSi4ZGaAOZLo',
    appId: '1:5911714952:android:73af9aa6324cce1d7f933d',
    messagingSenderId: '5911714952',
    projectId: 'fir-main-8b658',
    storageBucket: 'fir-main-8b658.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADWmTUrXgNMvuveO_RV8l5ixufmCo86ls',
    appId: '1:5911714952:ios:342de9b085d8b8437f933d',
    messagingSenderId: '5911714952',
    projectId: 'fir-main-8b658',
    storageBucket: 'fir-main-8b658.appspot.com',
    androidClientId: '5911714952-go3gtp6kmompd4toj250n787eftog5or.apps.googleusercontent.com',
    iosClientId: '5911714952-v86uuplll6n6okmat6rsglph7vecj0mr.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebasemain',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyADWmTUrXgNMvuveO_RV8l5ixufmCo86ls',
    appId: '1:5911714952:ios:092db14aaaa0c72e7f933d',
    messagingSenderId: '5911714952',
    projectId: 'fir-main-8b658',
    storageBucket: 'fir-main-8b658.appspot.com',
    androidClientId: '5911714952-go3gtp6kmompd4toj250n787eftog5or.apps.googleusercontent.com',
    iosClientId: '5911714952-tre67p3ib8mo3gfnjss76q42saugi45n.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebasemain.RunnerTests',
  );
}
