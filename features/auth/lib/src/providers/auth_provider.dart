import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    final signInUseCase = appLocator<SignInUseCase>();
    final signUpUseCase = appLocator<SignUpUseCase>();
    final signOutUseCase = appLocator<SignOutUseCase>();

    return AuthNotifier(
      signInUseCase: signInUseCase,
      signUpUseCase: signUpUseCase,
      signOutUseCase: signOutUseCase,
    );
  },
);
