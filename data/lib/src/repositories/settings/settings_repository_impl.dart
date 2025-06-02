part of repositories;

final class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferencesProvider _sharedPreferencesProvider;
  final FirebaseProvider _firebaseProvider;

  const SettingsRepositoryImpl({
    required SharedPreferencesProvider sharedPreferencesProvider,
    required FirebaseProvider firebaseProvider,
  })  : _sharedPreferencesProvider = sharedPreferencesProvider,
        _firebaseProvider = firebaseProvider;

  @override
  Future<void> changeLocale(Locale locale) async {
    await _sharedPreferencesProvider.saveLocale(locale);
  }

  @override
  Future<Locale> fetchCurrentLocale() async {
    return _sharedPreferencesProvider.getLocale();
  }

  @override
  Future<User> fetchCurrentUser() async {
    final UserEntity entity = await _firebaseProvider.fetchCurrentUser();
    return MapperFactory.userMapper.fromEntity(entity);
  }

  @override
  Future<void> changeUserData(User user) async {
    await _firebaseProvider.changeUserData(user);
  }

  @override
  Future<bool> checkEmailConsistency() {
    return _firebaseProvider.checkEmailConsistency();
  }

  @override
  Future<void> changeThemeMode({
    required bool isDark,
  }) async {
    await _sharedPreferencesProvider.saveThemeMode(isDark: isDark);
  }

  @override
  Future<void> changeThemeType({
    required bool isSystemTheme,
  }) async {
    await _sharedPreferencesProvider.saveThemeType(
        isSystemTheme: isSystemTheme);
  }

  @override
  Future<bool> fetchThemeMode() async {
    return _sharedPreferencesProvider.themeMode;
  }

  @override
  Future<bool> fetchThemeType() async {
    return _sharedPreferencesProvider.themeType;
  }
}
