part of use_cases;

final class FetchCurrentLocaleUseCase
    implements FutureUseCase<Locale, NoParams> {
  final SettingsRepository _settingsRepository;

  const FetchCurrentLocaleUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<Locale> execute(NoParams input) async {
    return _settingsRepository.fetchCurrentLocale();
  }
}
