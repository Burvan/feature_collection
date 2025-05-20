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
  CheckEmailVerificationUseCase checkEmailVerificationUseCase(
    AuthRepository authRepository,
  ) {
    return CheckEmailVerificationUseCase(authRepository: authRepository);
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
  GetCurrentUserUseCase getCurrentUserUseCase(
    SettingsRepository settingsRepository,
  ) {
    return GetCurrentUserUseCase(settingsRepository: settingsRepository);
  }

  @lazySingleton
  ChangeThemeTypeUseCase changeThemeTypeUseCase(
    SettingsRepository settingsRepository,
  ) {
    return ChangeThemeTypeUseCase(settingsRepository: settingsRepository);
  }

  @lazySingleton
  ChangeThemeModeUseCase changeThemeModeUseCase(
    SettingsRepository settingsRepository,
  ) {
    return ChangeThemeModeUseCase(settingsRepository: settingsRepository);
  }

  @lazySingleton
  GetCurrentThemeTypeUseCase getCurrentThemeTypeUseCase(
    SettingsRepository settingsRepository,
  ) {
    return GetCurrentThemeTypeUseCase(settingsRepository: settingsRepository);
  }

  @lazySingleton
  GetCurrentThemeModeUseCase getCurrentThemeModeUseCase(
    SettingsRepository settingsRepository,
  ) {
    return GetCurrentThemeModeUseCase(settingsRepository: settingsRepository);
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

  @lazySingleton
  CheckEmailConsistencyUseCase checkEmailConsistencyUseCase(
    SettingsRepository settingsRepository,
  ) {
    return CheckEmailConsistencyUseCase(settingsRepository: settingsRepository);
  }
}
