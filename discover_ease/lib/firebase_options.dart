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
    apiKey: '', // NEED TO PUT API KEYS
    appId: '1:967166826493:web:430cb2ef8ab37d645b6b94',
    messagingSenderId: '967166826493',
    projectId: 'discoverease-418713',
    authDomain: 'discoverease-418713.firebaseapp.com',
    storageBucket: 'discoverease-418713.appspot.com',
    measurementId: 'G-366ZZ66LT8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '',
    appId: '1:967166826493:android:ba41991034f67ec15b6b94',
    messagingSenderId: '967166826493',
    projectId: 'discoverease-418713',
    storageBucket: 'discoverease-418713.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '1:967166826493:ios:f6625f90a9a44bf95b6b94',
    messagingSenderId: '967166826493',
    projectId: 'discoverease-418713',
    storageBucket: 'discoverease-418713.appspot.com',
    iosBundleId: 'com.example.discoverEase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: '',
    appId: '1:967166826493:ios:25cd01004afddc0f5b6b94',
    messagingSenderId: '967166826493',
    projectId: 'discoverease-418713',
    storageBucket: 'discoverease-418713.appspot.com',
    iosBundleId: 'com.example.discoverEase.RunnerTests',
  );
  
}
