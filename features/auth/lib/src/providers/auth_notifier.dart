import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;

  AuthNotifier({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
  }) : super(const AuthState.initial());

  Future<void> signIn(
    String email,
    String password,
  ) async {
    state = const AuthState.loading();
    try {
      await signInUseCase.execute(
        SignInPayload(
          email: email,
          password: password,
        ),
      );
      state = const AuthState.success();
    } on AppException catch (e) {
      state = AuthState.failure(e);
    } catch (e) {
      state = AuthState.failure(AppException.unknown(message: e.toString()));
    }
  }

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
    required String gender,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();
    try {
      await signUpUseCase.execute(
        SignUpPayload(
          firstName: firstName,
          lastName: lastName,
          dateOfBirth: dateOfBirth,
          gender: gender,
          phoneNumber: phoneNumber,
          email: email,
          password: password,
        ),
      );
      state = const AuthState.success();
    } on AppException catch (e) {
      state = AuthState.failure(e);
    } catch (e) {
      state = AuthState.failure(AppException.unknown(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    state = const AuthState.loading();
    try {
      await signOutUseCase.execute(const NoParams());
      state = const AuthState.success();
    } on AppException catch (e) {
      state = AuthState.failure(e);
    } catch (e) {
      state = AuthState.failure(AppException.unknown(message: e.toString()));
    }
  }
}
