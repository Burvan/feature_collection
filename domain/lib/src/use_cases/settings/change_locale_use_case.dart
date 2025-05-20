part of use_cases;

final class ChangeLocaleUseCase implements FutureUseCase<void, Locale> {
  final SettingsRepository _settingsRepository;

  const ChangeLocaleUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<void> execute(Locale input) async {
    await _settingsRepository.changeLocale(input);
  }
}
