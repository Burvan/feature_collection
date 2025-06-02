part of providers;

final class SharedPreferencesProvider {
  final SharedPreferences _prefs;

  SharedPreferencesProvider({
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  Future<void> saveLocale(Locale locale) async {
    await _prefs.setString(
      DataConstants.localeKey,
      '${locale.languageCode}_${locale.countryCode}',
    );
  }

  Locale getLocale() {
    final String localeStr = _prefs.getString(DataConstants.localeKey) ??
        '${PlatformDispatcher.instance.locale.languageCode}'
            '_${PlatformDispatcher.instance.locale.countryCode}';

    return AppLocalization.supportedLocales.firstWhere(
      (Locale locale) => locale.toString() == localeStr,
      orElse: () => AppLocalization.fallbackLocale,
    );
  }

  Future<void> saveThemeType({required bool isSystemTheme}) async {
    await _prefs.setBool(DataConstants.themeTypeKey, isSystemTheme);
  }

  Future<void> saveThemeMode({required bool isDark}) async {
    await _prefs.setBool(DataConstants.themeModeKey, isDark);
  }

  bool get themeType => _prefs.getBool(DataConstants.themeTypeKey) ?? false;

  bool get themeMode => _prefs.getBool(DataConstants.themeModeKey) ?? false;
}
