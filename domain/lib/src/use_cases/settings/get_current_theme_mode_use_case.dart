part of use_cases;

final class GetCurrentThemeModeUseCase
    implements FutureUseCase<bool, NoParams> {
  final SettingsRepository _settingsRepository;

  const GetCurrentThemeModeUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<bool> execute(NoParams input) async {
    return _settingsRepository.getThemeMode();
  }
}
