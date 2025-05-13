part of use_cases;

final class ChangeUserDataUseCase implements FutureUseCase<void, LoginPayload> {
  final SettingsRepository _settingsRepository;

  const ChangeUserDataUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<void> execute(LoginPayload input) async {
    await _settingsRepository.changeUserData(input);
  }
}