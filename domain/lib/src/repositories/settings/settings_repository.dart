part of repositories;

abstract interface class SettingsRepository {
  Future<void> changeUserData(LoginPayload payload);

  Future<void> changeLocale(Locale locale);
  Future<Locale> getCurrentLocale();

  Future<void> changeTheme(AppTheme theme);
  Future<AppTheme> getCurrentTheme();

  Future<String?> getAvatar();
  Future<void> changeAvatar(Uint8List imageBytes);
  Future<void> deleteAvatar();
}