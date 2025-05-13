import 'package:core/core.dart';
import 'package:domain/domain.dart';

@module
abstract class DomainModule {
  @lazySingleton
  SignInUseCase signInUseCase(AuthRepository authRepository) {
    return SignInUseCase(authRepository: authRepository);
  }

  @lazySingleton
  SignUpUseCase signUpUseCase(AuthRepository authRepository) {
    return SignUpUseCase(authRepository: authRepository);
  }

  @lazySingleton
  SignOutUseCase signOutUseCase(AuthRepository authRepository) {
    return SignOutUseCase(authRepository: authRepository);
  }

  @lazySingleton
  FetchCharactersUseCase fetchCharactersUseCase(
    CharacterRepository characterRepository,
  ) {
    return FetchCharactersUseCase(characterRepository: characterRepository);
  }

  @lazySingleton
  AddCharacterUseCase addCharacterUseCase(
    CharacterRepository characterRepository,
  ) {
    return AddCharacterUseCase(characterRepository: characterRepository);
  }

  @lazySingleton
  ChangeAvatarUseCase changeAvatarUseCase(
    SettingsRepository settingsRepository,
  ) {
    return ChangeAvatarUseCase(settingsRepository: settingsRepository);
  }

  @lazySingleton
  DeleteAvatarUseCase deleteAvatarUseCase(
    SettingsRepository settingsRepository,
  ) {
    return DeleteAvatarUseCase(settingsRepository: settingsRepository);
  }

  @lazySingleton
  GetAvatarUseCase getAvatarUseCase(
    SettingsRepository settingsRepository,
  ) {
    return GetAvatarUseCase(settingsRepository: settingsRepository);
  }

  @lazySingleton
  ChangeThemeUseCase changeThemeUseCase(
    SettingsRepository settingsRepository,
  ) {
    return ChangeThemeUseCase(settingsRepository: settingsRepository);
  }

  @lazySingleton
  GetCurrentThemeUseCase getThemeUseCase(
    SettingsRepository settingsRepository,
  ) {
    return GetCurrentThemeUseCase(settingsRepository: settingsRepository);
  }

  @lazySingleton
  ChangeLocaleUseCase changeLocaleUseCase(
    SettingsRepository settingsRepository,
  ) {
    return ChangeLocaleUseCase(settingsRepository: settingsRepository);
  }

  @lazySingleton
  GetCurrentLocaleUseCase getCurrentLocaleUseCase(
    SettingsRepository settingsRepository,
  ) {
    return GetCurrentLocaleUseCase(settingsRepository: settingsRepository);
  }

  @lazySingleton
  ChangeUserDataUseCase changeUserDataUseCase(
    SettingsRepository settingsRepository,
  ) {
    return ChangeUserDataUseCase(settingsRepository: settingsRepository);
  }
}
