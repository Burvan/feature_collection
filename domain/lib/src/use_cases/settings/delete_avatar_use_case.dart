part of use_cases;

final class DeleteAvatarUseCase implements FutureUseCase<void, NoParams> {
  final SettingsRepository _settingsRepository;

  const DeleteAvatarUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<void> execute(NoParams input) async {
    await _settingsRepository.deleteAvatar();
  }
}