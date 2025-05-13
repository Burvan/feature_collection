part of use_cases;

final class GetCurrentLocaleUseCase implements FutureUseCase<Locale, NoParams> {
  final SettingsRepository _settingsRepository;

  const GetCurrentLocaleUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<Locale> execute(NoParams input) async {
    return _settingsRepository.getCurrentLocale();
  }
}
