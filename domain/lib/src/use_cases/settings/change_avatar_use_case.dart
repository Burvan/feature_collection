part of use_cases;

final class ChangeAvatarUseCase implements FutureUseCase<void, Uint8List> {
  final SettingsRepository _settingsRepository;

  const ChangeAvatarUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<void> execute(Uint8List input) async {
    await _settingsRepository.changeAvatar(input);
  }
}