part of use_cases;

final class SignOutUseCase implements FutureUseCase<void, NoParams> {
  final AuthRepository _authRepository;

  const SignOutUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<void> execute(NoParams input) async {
    await _authRepository.signOut();
  }
}
