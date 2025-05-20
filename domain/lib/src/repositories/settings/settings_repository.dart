part of repositories;

abstract interface class SettingsRepository {
  Future<void> changeLocale(Locale locale);
  Future<Locale> getCurrentLocale();

  Future<void> changeThemeType({required bool isSystemTheme});
  Future<void> changeThemeMode({required bool isDark});
  Future<bool> getThemeType();
  Future<bool> getThemeMode();

  Future<void> changeUserData(User user);
  Future<User> getCurrentUser();
  Future<bool> checkEmailConsistency();
}
