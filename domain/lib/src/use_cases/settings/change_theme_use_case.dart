part of use_cases;

final class ChangeThemeUseCase implements FutureUseCase<void, AppTheme> {
  final SettingsRepository _settingsRepository;

  const ChangeThemeUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<void> execute(AppTheme input) async {
    await _settingsRepository.changeTheme(input);
  }
}