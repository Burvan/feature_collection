import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:home_page/home_page.dart';
import 'package:navigation/navigation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  late final AppRouter _appRouter;
  late final SignInUseCase _signInUseCase;
  late final SignUpUseCase _signUpUseCase;
  late final SignOutUseCase _signOutUseCase;
  late final CheckEmailVerificationUseCase _checkEmailVerificationUseCase;

  @override
  Future<AuthState> build() async {
    _appRouter = appLocator<AppRouter>();
    _signInUseCase = appLocator<SignInUseCase>();
    _signUpUseCase = appLocator<SignUpUseCase>();
    _signOutUseCase = appLocator<SignOutUseCase>();
    _checkEmailVerificationUseCase =
        appLocator<CheckEmailVerificationUseCase>();

    return const AuthState.initial();
  }

  Future<void> signIn() async {
    final AuthFormState formState = ref.read(authFormControllerProvider);
    state = const AsyncValue<AuthState>.loading();

    try {
      await _signInUseCase.execute(
        SignInPayload(
          email: formState.email,
          password: formState.password,
        ),
      );

      await _checkEmailVerificationUseCase.execute(const NoParams());

      state = const AsyncValue<AuthState>.data(AuthState.success());
      await _appRouter.pushAndPopUntil(
        const HomeRoute(),
        predicate: (_) => false,
      );
    } on AppException catch (e, stackTrace) {
      state = AsyncValue<AuthState>.error(e, stackTrace);
    }
  }

  Future<void> signUp() async {
    final AuthFormState formState = ref.read(authFormControllerProvider);
    state = const AsyncValue<AuthState>.loading();

    try {
      await _signUpUseCase.execute(
        SignUpPayload(
          firstName: formState.firstName,
          lastName: formState.lastName,
          dateOfBirth: formState.dateOfBirth!,
          gender: formState.gender!,
          phoneNumber: formState.phoneNumber,
          email: formState.email,
          password: formState.password,
        ),
      );
      state = const AsyncValue<AuthState>.data(AuthState.success());
      await _appRouter.push(
        const VerificationRequiredRoute(),
      );
    } on AppException catch (e, stackTrace) {
      state = AsyncValue<AuthState>.error(e, stackTrace);
    }
  }

  Future<void> checkVerification() async {
    state = const AsyncValue<AuthState>.loading();

    try {
      await _checkEmailVerificationUseCase.execute(
        const NoParams(),
      );

      state = const AsyncValue<AuthState>.data(AuthState.success());

      await _appRouter.pushAndPopUntil(
        const HomeRoute(),
        predicate: (_) => false,
      );
    } on AppException catch (e, stackTrace) {
      state = AsyncValue<AuthState>.error(e, stackTrace);
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue<AuthState>.loading();

    try {
      await _signOutUseCase.execute(const NoParams());
      state = const AsyncValue<AuthState>.data(AuthState.success());
      await _appRouter.pushAndPopUntil(
        const SignInRoute(),
        predicate: (_) => false,
      );
    } on AppException catch (e, stackTrace) {
      state = AsyncValue<AuthState>.error(e, stackTrace);
    }
  }

  Future<void> navigateToSignUp() async {
    state = const AsyncValue<AuthState>.data(AuthState.initial());
    await _appRouter.push(const SignUpRoute());
  }

  Future<void> navigateToSignIn() async {
    state = const AsyncValue<AuthState>.data(AuthState.initial());
    await _appRouter.push(const SignInRoute());
  }
}
