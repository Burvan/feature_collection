part of use_cases;

final class SignUpUseCase implements FutureUseCase<User, SignUpPayload> {
  final AuthRepository _authRepository;

  const SignUpUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<User> execute(SignUpPayload input) async {
    return _authRepository.signUp(input);
  }
}
