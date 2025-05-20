part of providers;

final class SharedPreferencesProvider {
  late final SharedPreferences _prefs;

  SharedPreferencesProvider();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveLocale(Locale locale) async {
    await _prefs.setString(
      DataConstants.localeKey,
      '${locale.languageCode}_${locale.countryCode}',
    );
  }

  Locale getLocale() {
    final String localeStr = _prefs.getString(DataConstants.localeKey) ??
        DataConstants.defaultLocale;

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

  bool getThemeType() {
    return _prefs.getBool(DataConstants.themeTypeKey) ?? false;
  }

  bool getThemeMode() {
    return _prefs.getBool(DataConstants.themeModeKey) ?? false;
  }
}
