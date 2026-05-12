// lib/core/providers/locale_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:navithera_client/feature/auth/presentation/providers/auth_provider.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier(ref.read(secureStorageProvider));
});

class LocaleNotifier extends StateNotifier<Locale> {
  final FlutterSecureStorage _storage;

  LocaleNotifier(this._storage) : super(const Locale('en')) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final languageCode = await _storage.read(key: 'languageCode') ?? 'en';
    state = Locale(languageCode);
  }

  Future<void> setLocale(Locale locale) async {
    await _storage.write(key: 'languageCode', value: locale.languageCode);
    state = locale;
  }
}
