import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/strings.dart';

enum AppLanguage { ru, en }

class SettingsService extends ChangeNotifier {
  static const _kTheme = 'jarin.theme.dark';
  static const _kLang = 'jarin.lang';
  static const _kPitch = 'jarin.pitch';
  static const _kRate = 'jarin.rate';
  static const _kWhisper = 'jarin.whisper';
  static const _kUserEmail = 'jarin.user_email';
  static const _kUserName = 'jarin.user_name';
  static const _kThemeMigrated = 'jarin.theme.migrated';

  late SharedPreferences _prefs;
  ThemeMode _themeMode = ThemeMode.dark; // Тёмная тема по умолчанию
  AppLanguage _language = AppLanguage.ru;
  double _pitch = 0.85;
  double _rate = 0.5;
  bool _whisper = false;
  String? _userEmail;
  String? _userName;

  ThemeMode get themeMode => _themeMode;
  AppLanguage get language => _language;
  double get pitch => _pitch;
  double get rate => _rate;
  bool get whisper => _whisper;
  String? get userEmail => _userEmail;
  String? get userName => _userName;
  bool get isLoggedIn => _userEmail != null && _userEmail!.isNotEmpty;

  Strings get strings => Strings(isRu: _language == AppLanguage.ru);
  String get ttsLocale => _language == AppLanguage.ru ? 'ru-RU' : 'en-US';

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    // Миграция: старый баг инвертировал dark/light. Один раз сбрасываем
    if (!_prefs.containsKey(_kThemeMigrated)) {
      await _prefs.remove(_kTheme);
      await _prefs.setBool(_kThemeMigrated, true);
    }
    _themeMode =
        _prefs.getBool(_kTheme) == false ? ThemeMode.light : ThemeMode.dark;
    _language = _prefs.getString(_kLang) == 'en'
        ? AppLanguage.en
        : AppLanguage.ru;
    _pitch = _prefs.getDouble(_kPitch) ?? 0.85;
    _rate = _prefs.getDouble(_kRate) ?? 0.5;
    _whisper = _prefs.getBool(_kWhisper) ?? false;
    _userEmail = _prefs.getString(_kUserEmail);
    _userName = _prefs.getString(_kUserName);
    notifyListeners();
  }

  Future<void> setTheme(ThemeMode mode) async {
    _themeMode = mode;
    await _prefs.setBool(_kTheme, mode == ThemeMode.dark);
    notifyListeners();
  }

  void toggleTheme() {
    setTheme(_themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }

  Future<void> setLanguage(AppLanguage lang) async {
    _language = lang;
    await _prefs.setString(_kLang, lang == AppLanguage.en ? 'en' : 'ru');
    notifyListeners();
  }

  Future<void> setPitch(double value) async {
    _pitch = value;
    await _prefs.setDouble(_kPitch, value);
    notifyListeners();
  }

  Future<void> setRate(double value) async {
    _rate = value;
    await _prefs.setDouble(_kRate, value);
    notifyListeners();
  }

  Future<void> setWhisper(bool value) async {
    _whisper = value;
    await _prefs.setBool(_kWhisper, value);
    notifyListeners();
  }

  Future<void> signIn(String email, {String? name}) async {
    _userEmail = email;
    _userName = name ?? email.split('@').first;
    await _prefs.setString(_kUserEmail, email);
    await _prefs.setString(_kUserName, _userName!);
    notifyListeners();
  }

  Future<void> signOut() async {
    _userEmail = null;
    _userName = null;
    await _prefs.remove(_kUserEmail);
    await _prefs.remove(_kUserName);
    notifyListeners();
  }
}
