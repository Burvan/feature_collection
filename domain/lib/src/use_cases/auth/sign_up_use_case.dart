part of use_cases;

final class SignUpUseCase implements FutureUseCase<void, SignUpPayload> {
  final AuthRepository _authRepository;

  const SignUpUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<void> execute(SignUpPayload input) async {
    await _authRepository.signUp(input);
    await _authRepository.sendEmailVerification();
  }
}
