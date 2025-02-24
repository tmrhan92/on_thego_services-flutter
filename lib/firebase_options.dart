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
    apiKey: 'AIzaSyDTYgRg05XzR_Nsl4qaSlnpuYA7YSKAW3U',
    appId: '1:513002780826:web:6932b1dc0183822150c723',
    messagingSenderId: '513002780826',
    projectId: 'services-app-d9437',
    authDomain: 'services-app-d9437.firebaseapp.com',
    storageBucket: 'services-app-d9437.firebasestorage.app',
    measurementId: 'G-9XRHDTW12J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB_EaPlvtSzN0dbLIpZty4E8WyOPdvs4H8',
    appId: '1:513002780826:android:31e6b90ff72f4c5d50c723',
    messagingSenderId: '513002780826',
    projectId: 'services-app-d9437',
    storageBucket: 'services-app-d9437.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmiNBGdyPj968axZ9ZPiNQKtXUoTzxiEo',
    appId: '1:513002780826:ios:7fe46755aaa1997b50c723',
    messagingSenderId: '513002780826',
    projectId: 'services-app-d9437',
    storageBucket: 'services-app-d9437.firebasestorage.app',
    iosBundleId: 'com.example.massageApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDmiNBGdyPj968axZ9ZPiNQKtXUoTzxiEo',
    appId: '1:513002780826:ios:7fe46755aaa1997b50c723',
    messagingSenderId: '513002780826',
    projectId: 'services-app-d9437',
    storageBucket: 'services-app-d9437.firebasestorage.app',
    iosBundleId: 'com.example.massageApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDTYgRg05XzR_Nsl4qaSlnpuYA7YSKAW3U',
    appId: '1:513002780826:web:ca16cae3d9e0565250c723',
    messagingSenderId: '513002780826',
    projectId: 'services-app-d9437',
    authDomain: 'services-app-d9437.firebaseapp.com',
    storageBucket: 'services-app-d9437.firebasestorage.app',
    measurementId: 'G-RZJ80B640J',
  );
}
