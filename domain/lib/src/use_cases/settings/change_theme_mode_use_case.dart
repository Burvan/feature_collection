part of use_cases;

final class ChangeThemeModeUseCase implements FutureUseCase<void, bool> {
  final SettingsRepository _settingsRepository;

  const ChangeThemeModeUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<void> execute(bool input) async {
    await _settingsRepository.changeThemeMode(isDark: input);
  }
}
