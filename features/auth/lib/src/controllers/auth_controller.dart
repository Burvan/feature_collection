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

  @override
  Future<AuthState> build() async {
    _appRouter = appLocator<AppRouter>();
    _signInUseCase = appLocator<SignInUseCase>();
    _signUpUseCase = appLocator<SignUpUseCase>();
    _signOutUseCase = appLocator<SignOutUseCase>();

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
      state = const AsyncValue<AuthState>.data(AuthState.success());
      await _appRouter.pushAndPopUntil(
        const HomeRoute(),
        predicate: (_) => false,
      );
    } on AppException catch (e, stackTrace) {
      state = AsyncValue<AuthState>.error(e, stackTrace);
    } catch (e, stackTrace) {
      state = AsyncValue<AuthState>.error(
        AppException.unknown(message: e.toString()),
        stackTrace,
      );
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
      await _appRouter.pushAndPopUntil(
        const HomeRoute(),
        predicate: (_) => false,
      );
    } on AppException catch (e, stackTrace) {
      state = AsyncValue<AuthState>.error(e, stackTrace);
    } catch (e, stackTrace) {
      state = AsyncValue<AuthState>.error(
        AppException.unknown(message: e.toString()),
        stackTrace,
      );
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
    } catch (e, stackTrace) {
      state = AsyncValue<AuthState>.error(
        AppException.unknown(message: e.toString()),
        stackTrace,
      );
    }
  }

  Future<void> navigateToSignUp() async {
    await _appRouter.push(const SignUpRoute());
  }

  Future<void> navigateToSignIn() async {
    await _appRouter.pushAndPopUntil(
      const SignInRoute(),
      predicate: (_) => false,
    );
  }
}
