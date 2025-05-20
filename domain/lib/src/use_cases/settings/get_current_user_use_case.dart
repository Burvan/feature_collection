part of use_cases;

final class GetCurrentUserUseCase implements FutureUseCase<User, NoParams> {
  final SettingsRepository _settingsRepository;

  const GetCurrentUserUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<User> execute(NoParams input) async {
    return _settingsRepository.getCurrentUser();
  }
}