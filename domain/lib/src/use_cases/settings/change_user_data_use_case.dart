part of use_cases;

final class ChangeUserDataUseCase implements FutureUseCase<void, User> {
  final SettingsRepository _settingsRepository;

  const ChangeUserDataUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<void> execute(User input) async {
    await _settingsRepository.changeUserData(input);
  }
}