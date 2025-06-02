part of use_cases;

final class FetchCurrentUserUseCase implements FutureUseCase<User, NoParams> {
  final SettingsRepository _settingsRepository;

  const FetchCurrentUserUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<User> execute(NoParams input) async {
    return _settingsRepository.fetchCurrentUser();
  }
}
