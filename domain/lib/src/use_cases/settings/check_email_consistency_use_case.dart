part of use_cases;

final class CheckEmailConsistencyUseCase
    implements FutureUseCase<bool, NoParams> {
  final SettingsRepository _settingsRepository;

  const CheckEmailConsistencyUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<bool> execute(NoParams input) async {
    return _settingsRepository.checkEmailConsistency();
  }
}
