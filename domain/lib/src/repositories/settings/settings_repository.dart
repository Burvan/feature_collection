part of repositories;

abstract interface class SettingsRepository {
  Future<void> changeLocale(Locale locale);
  Future<Locale> fetchCurrentLocale();

  Future<void> changeThemeType({required bool isSystemTheme});
  Future<void> changeThemeMode({required bool isDark});
  Future<bool> fetchThemeType();
  Future<bool> fetchThemeMode();

  Future<void> changeUserData(User user);
  Future<User> fetchCurrentUser();
  Future<bool> checkEmailConsistency();
}
