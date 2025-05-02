import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale?>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale?> {
  LocaleNotifier() : super(null) {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString('languageCode');

    if (languageCode != null) {
      state = Locale(languageCode);
    }
  }

  Future<void> changeLocale(Locale? locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();

    if (locale == null) {
      await prefs.remove('languageCode');
    } else {
      await prefs.setString('languageCode', locale.languageCode);
    }
  }

  Future<void> useSystemLocale() async => await changeLocale(null);
}
