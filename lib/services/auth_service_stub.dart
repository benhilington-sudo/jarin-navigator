import 'package:flutter/foundation.dart';

import 'auth_service.dart';

abstract class AuthServiceImpl extends ChangeNotifier {
  AuthUser? get user;
  bool get isLoggedIn;
  Future<String?> signInWithGoogle();
  Future<String?> signInWithEmail(String email, String password);
  Future<String?> registerWithEmail(String email, String password, {String? name});
  Future<void> sendVerification();
  Future<bool> reloadAndCheckEmailVerified();
  Future<void> signOut();
}

class _StubAuthServiceImpl extends AuthServiceImpl {
  @override
  AuthUser? get user => null;
  @override
  bool get isLoggedIn => false;
  @override
  Future<String?> signInWithGoogle() async => 'Firebase недоступен на web';
  @override
  Future<String?> signInWithEmail(String email, String password) async => 'Firebase недоступен на web';
  @override
  Future<String?> registerWithEmail(String email, String password, {String? name}) async => 'Firebase недоступен на web';
  @override
  Future<void> sendVerification() async {}
  @override
  Future<bool> reloadAndCheckEmailVerified() async => false;
  @override
  Future<void> signOut() async {}
}

AuthServiceImpl createAuthServiceImpl() => _StubAuthServiceImpl();
