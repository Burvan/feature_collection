part of use_cases;

final class SignInUseCase implements FutureUseCase<User, SignInPayload> {
  final AuthRepository _authRepository;

  const SignInUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<User> execute(SignInPayload input) async {
    return _authRepository.signIn(input);
  }
}
