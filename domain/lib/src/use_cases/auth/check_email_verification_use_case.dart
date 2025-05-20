part of use_cases;

final class CheckEmailVerificationUseCase
    implements FutureUseCase<void, NoParams> {
  final AuthRepository _authRepository;

  const CheckEmailVerificationUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<void> execute(NoParams input) async {
    await _authRepository.checkEmailVerification();
  }
}
