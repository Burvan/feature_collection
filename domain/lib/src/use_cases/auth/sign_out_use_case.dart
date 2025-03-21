import 'package:domain/domain.dart';

final class SignOutUseCase implements FutureUseCase<void, NoParams> {
  final AuthRepository _authRepository;

  SignOutUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<void> execute(NoParams input) async {
    await _authRepository.signOut();
  }
}
