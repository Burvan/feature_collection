import 'package:core/core.dart';
import 'package:domain/domain.dart';

@module
abstract class DomainModule {
  @lazySingleton
  SignInUseCase signInUseCase(AuthRepository authRepository) =>
      SignInUseCase(authRepository: authRepository);

  @lazySingleton
  SignUpUseCase signUpUseCase(AuthRepository authRepository) =>
      SignUpUseCase(authRepository: authRepository);

  @lazySingleton
  SignOutUseCase signOutUseCase(AuthRepository authRepository) =>
      SignOutUseCase(authRepository: authRepository);
}