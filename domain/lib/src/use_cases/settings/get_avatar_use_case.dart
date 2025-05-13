part of use_cases;

final class GetAvatarUseCase implements FutureUseCase<String?, NoParams> {
  final SettingsRepository _settingsRepository;

  const GetAvatarUseCase({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<String?> execute(NoParams input) async {
    return _settingsRepository.getAvatar();
  }
}