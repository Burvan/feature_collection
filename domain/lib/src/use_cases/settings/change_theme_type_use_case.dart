part of use_cases;

final class ChangeThemeTypeUseCase implements FutureUseCase<void, bool> {
  final SettingsRepository _settingsRepository;

  const ChangeThemeTypeUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<void> execute(bool input) async {
    await _settingsRepository.changeThemeType(isSystemTheme: input);
  }
}
