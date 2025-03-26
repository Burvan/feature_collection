import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';

final StateNotifierProvider<AuthNotifier, AuthState> authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    final SignInUseCase signInUseCase = appLocator<SignInUseCase>();
    final SignUpUseCase signUpUseCase = appLocator<SignUpUseCase>();
    final SignOutUseCase signOutUseCase = appLocator<SignOutUseCase>();

    return AuthNotifier(
      signInUseCase: signInUseCase,
      signUpUseCase: signUpUseCase,
      signOutUseCase: signOutUseCase,
    );
  },
);

final StateNotifierProvider<FormNotifier, AuthFormState> formNotifierProvider =
    StateNotifierProvider<FormNotifier, AuthFormState>(
  (ref) => FormNotifier(),
);
