import 'dart:async';

import 'package:flutter/foundation.dart';

import 'auth_service_stub.dart'
    if (dart.library.io) 'auth_service_native.dart' as impl;

class AuthUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final bool emailVerified;

  const AuthUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.emailVerified = false,
  });
}

abstract class AuthServiceImpl extends ChangeNotifier {
  AuthUser? get user;
  bool get isLoggedIn;
  Future<String?> signInWithGoogle();
  Future<String?> signInWithEmail(String email, String password);
  Future<String?> registerWithEmail(String email, String password,
      {String? name});
  Future<void> sendVerification();
  Future<bool> reloadAndCheckEmailVerified();
  Future<void> signOut();
}

class AuthService extends ChangeNotifier {
  late final AuthServiceImpl _impl;

  AuthUser? get user => _impl.user;
  bool get isLoggedIn => _impl.isLoggedIn;

  AuthService() {
    _impl = impl.createAuthServiceImpl();
    _impl.addListener(notifyListeners);
  }

  Future<String?> signInWithGoogle() => _impl.signInWithGoogle();
  Future<String?> signInWithEmail(String email, String password) => _impl.signInWithEmail(email, password);
  Future<String?> registerWithEmail(String email, String password, {String? name}) => _impl.registerWithEmail(email, password, name: name);
  Future<void> sendVerification() => _impl.sendVerification();
  Future<bool> reloadAndCheckEmailVerified() => _impl.reloadAndCheckEmailVerified();
  Future<void> signOut() => _impl.signOut();
}
