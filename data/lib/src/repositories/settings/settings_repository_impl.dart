part of repositories;

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsProvider _settingsProvider;

  SettingsRepositoryImpl({
    required SettingsProvider settingsProvider,
  }) : _settingsProvider = settingsProvider;

  @override
  Future<void> changeLocale(Locale locale) async {
    await _settingsProvider.saveLocale(locale);
  }

  @override
  Future<Locale> getCurrentLocale() async {
    return _settingsProvider.getLocale();
  }

  @override
  Future<void> changeTheme(AppTheme theme) async {
    await _settingsProvider.saveTheme(theme);
  }

  @override
  Future<AppTheme> getCurrentTheme() async {
    return _settingsProvider.getTheme();
  }

  @override
  Future<void> changeAvatar(Uint8List imageBytes) async {
    final String avatar = base64Encode(imageBytes);
    await _settingsProvider.changeAvatar(avatar);
  }

  @override
  Future<void> deleteAvatar() async {
    await _settingsProvider.deleteAvatar();
  }

  @override
  Future<String?> getAvatar() async {
    return _settingsProvider.getAvatar();
  }

  @override
  Future<void> changeUserData(LoginPayload payload) async {
    await _settingsProvider.changeUserData(payload);
  }
}
