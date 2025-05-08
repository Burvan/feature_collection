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
}
