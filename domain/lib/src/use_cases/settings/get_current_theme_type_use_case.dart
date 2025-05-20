part of use_cases;

final class GetCurrentThemeTypeUseCase
    implements FutureUseCase<bool, NoParams> {
  final SettingsRepository _settingsRepository;

  const GetCurrentThemeTypeUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<bool> execute(NoParams input) async {
    return _settingsRepository.getThemeType();
  }
}
