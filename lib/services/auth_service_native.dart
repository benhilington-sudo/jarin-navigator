import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_service.dart';

class _NativeAuthServiceImpl extends AuthServiceImpl {
  FirebaseAuth? _auth;
  GoogleSignIn? _google;
  AuthUser? _user;
  StreamSubscription? _sub;

  @override
  AuthUser? get user => _user;
  @override
  bool get isLoggedIn => _user != null;

  _NativeAuthServiceImpl() {
    try {
      _auth = FirebaseAuth.instance;
      _google = GoogleSignIn(
        clientId: '582814618971-n2ggsm027ovc23f7arh65csl0t63nk1j.apps.googleusercontent.com',
      );
      _sub = _auth!.authStateChanges().listen((u) {
        _user = u != null ? AuthUser(uid: u.uid, email: u.email, displayName: u.displayName, photoUrl: u.photoURL, emailVerified: u.emailVerified) : null;
        notifyListeners();
      });
    } catch (e) {
      debugPrint('AuthService init error: $e');
    }
  }

  @override
  Future<String?> signInWithGoogle() async {
    if (_auth == null || _google == null) return 'Firebase не инициализирован';
    try {
      final account = await _google!.signIn();
      if (account == null) return 'Отменено пользователем';
      final auth = await account.authentication;
      final credential = GoogleAuthProvider.credential(accessToken: auth.accessToken, idToken: auth.idToken);
      await _auth!.signInWithCredential(credential);
      return null;
    } catch (e) {
      debugPrint('Google sign-in error: $e');
      return 'Войдите через email — Google Sign-In ещё не настроен';
    }
  }

  @override
  Future<String?> signInWithEmail(String email, String password) async {
    if (_auth == null) return 'Firebase не инициализирован';
    try {
      await _auth!.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') return 'Пользователь не найден';
      if (e.code == 'wrong-password') return 'Неверный пароль';
      if (e.code == 'invalid-email') return 'Некорректный email';
      if (e.code == 'user-disabled') return 'Аккаунт заблокирован';
      return 'Ошибка входа: ${e.message}';
    } catch (e) {
      return 'Ошибка входа';
    }
  }

  @override
  Future<String?> registerWithEmail(String email, String password, {String? name}) async {
    if (_auth == null) return 'Firebase не инициализирован';
    try {
      final cred = await _auth!.createUserWithEmailAndPassword(email: email, password: password);
      if (name != null && name.isNotEmpty) {
        await cred.user?.updateDisplayName(name);
      }
      await cred.user?.sendEmailVerification();
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') return 'Этот email уже зарегистрирован';
      if (e.code == 'invalid-email') return 'Некорректный email';
      if (e.code == 'weak-password') return 'Слишком слабый пароль';
      return 'Ошибка регистрации: ${e.message}';
    } catch (e) {
      return 'Ошибка регистрации';
    }
  }

  @override
  Future<void> sendVerification() async {
    await _auth?.currentUser?.sendEmailVerification();
  }

  @override
  Future<bool> reloadAndCheckEmailVerified() async {
    await _auth?.currentUser?.reload();
    final u = _auth?.currentUser;
    if (u != null) {
      _user = AuthUser(uid: u.uid, email: u.email, displayName: u.displayName, photoUrl: u.photoURL, emailVerified: u.emailVerified);
      notifyListeners();
      return u.emailVerified;
    }
    return false;
  }

  @override
  Future<void> signOut() async {
    await _google?.signOut();
    await _auth?.signOut();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

AuthServiceImpl createAuthServiceImpl() => _NativeAuthServiceImpl();
