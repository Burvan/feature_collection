part of use_cases;

final class FetchCurrentThemeModeUseCase
    implements FutureUseCase<bool, NoParams> {
  final SettingsRepository _settingsRepository;

  const FetchCurrentThemeModeUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<bool> execute(NoParams input) async {
    return _settingsRepository.fetchThemeMode();
  }
}
