part of use_cases;

final class GetCurrentThemeUseCase implements FutureUseCase<AppTheme, NoParams> {
  final SettingsRepository _settingsRepository;

  const GetCurrentThemeUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<AppTheme> execute(NoParams input) async {
    return _settingsRepository.getCurrentTheme();
  }
}