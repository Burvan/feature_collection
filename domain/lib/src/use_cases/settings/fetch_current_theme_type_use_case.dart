part of use_cases;

final class FetchCurrentThemeTypeUseCase
    implements FutureUseCase<bool, NoParams> {
  final SettingsRepository _settingsRepository;

  const FetchCurrentThemeTypeUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<bool> execute(NoParams input) async {
    return _settingsRepository.fetchThemeType();
  }
}
