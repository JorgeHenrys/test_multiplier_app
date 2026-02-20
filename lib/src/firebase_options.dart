import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAoYbqQgOJnT3sGdgcF4ohVh9tRMrYiIkc',
    appId: '1:262376135977:android:d7453d0ca6b1ae197a2b38',
    messagingSenderId: '262376135977',
    projectId: 'multiplier-app-6d757',
    storageBucket: 'multiplier-app-6d757.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAeetxASwNxVmqVzpZSYEV24op2NasMOCg',
    appId: '1:262376135977:ios:03d84f419a9015237a2b38',
    messagingSenderId: '262376135977',
    projectId: 'multiplier-app-6d757',
    storageBucket: 'multiplier-app-6d757.firebasestorage.app',
    iosBundleId: 'com.heinrkdev.testMultiplierApp',
  );
}
