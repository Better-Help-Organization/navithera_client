import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class FallbackMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode == 'om' ||
      locale.languageCode == 'ti' ||
      locale.languageCode == 'so';

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    // Fall back to English Material localizations for Oromo and Tigrinya
    return GlobalMaterialLocalizations.delegate.load(const Locale('en'));
  }

  @override
  bool shouldReload(FallbackMaterialLocalizationsDelegate old) => false;
}

class FallbackWidgetsLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const FallbackWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode == 'om' ||
      locale.languageCode == 'ti' ||
      locale.languageCode == 'so';

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    // Fall back to English Widgets localizations for Oromo and Tigrinya
    return GlobalWidgetsLocalizations.delegate.load(const Locale('en'));
  }

  @override
  bool shouldReload(FallbackWidgetsLocalizationsDelegate old) => false;
}

class FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode == 'om' ||
      locale.languageCode == 'ti' ||
      locale.languageCode == 'so';

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    // Fall back to English Cupertino localizations for Oromo and Tigrinya
    return GlobalCupertinoLocalizations.delegate.load(const Locale('en'));
  }

  @override
  bool shouldReload(FallbackCupertinoLocalizationsDelegate old) => false;
}
