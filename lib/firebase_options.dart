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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOIpbXbBcOmFVDS8tNQLm7aPw70xA6iVs',
    appId: '1:331717864633:android:f2faceb588a72d7c08ff68',
    messagingSenderId: '331717864633',
    projectId: 'leva-matrimonial-test',
    storageBucket: 'leva-matrimonial-test.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBx6XonIdYO1xH91as_AOMvFiTVVw1Dj4s',
    appId: '1:331717864633:ios:b0853cf2f8555f4408ff68',
    messagingSenderId: '331717864633',
    projectId: 'leva-matrimonial-test',
    storageBucket: 'leva-matrimonial-test.appspot.com',
    iosClientId: '331717864633-tdip4ds0a7mqs8m4djgrckv3opgk9h4e.apps.googleusercontent.com',
    iosBundleId: 'com.levamatrimonial.dev',
  );
}
