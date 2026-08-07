import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.android:
        return android;
      default:
        return web;
    }
  }

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDiTjwsPRug-bJ4cD516RA3Q_x4jE-ut1U',
    appId: '1:582814618971:ios:17d346de49c5fee565b67e',
    messagingSenderId: '582814618971',
    projectId: 'jarin-navigator',
    storageBucket: 'jarin-navigator.firebasestorage.app',
    iosBundleId: 'com.jarin.jarinNavigator',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDiTjwsPRug-bJ4cD516RA3Q_x4jE-ut1U',
    appId: '1:582814618971:android:placeholder',
    messagingSenderId: '582814618971',
    projectId: 'jarin-navigator',
    storageBucket: 'jarin-navigator.firebasestorage.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCoLkM1JLBZYvyqYfvQQvVhLbmouYYs07k',
    appId: '1:582814618971:web:cd94a3ddbbd948e065b67e',
    authDomain: 'jarin-navigator.firebaseapp.com',
    messagingSenderId: '582814618971',
    projectId: 'jarin-navigator',
    storageBucket: 'jarin-navigator.firebasestorage.app',
  );
}
