part of use_cases;

final class SignInUseCase implements FutureUseCase<void, SignInPayload> {
  final AuthRepository _authRepository;

  const SignInUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<void> execute(SignInPayload input) async {
    await _authRepository.signIn(input);
  }
}
