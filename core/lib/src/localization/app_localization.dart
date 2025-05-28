import 'dart:ui';

abstract final class AppLocalization {
  static const String langFolderPath = 'packages/core/resources/lang';

  static const List<Locale> supportedLocales = <Locale>[
    enLocale,
    ruLocale,
  ];

  static Locale get fallbackLocale => enLocale;

  static Locale get startLocale =>
      supportedLocales.contains(PlatformDispatcher.instance.locale)
          ? PlatformDispatcher.instance.locale
          : fallbackLocale;

  static const Locale enLocale = Locale('en', 'US');
  static const Locale ruLocale = Locale('ru', 'RU');

  static String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'ru':
        return 'Русский';
      case 'en':
        return 'English';
      default:
        return locale.languageCode.toUpperCase();
    }
  }
}
