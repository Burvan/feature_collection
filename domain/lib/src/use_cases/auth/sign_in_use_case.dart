import 'package:domain/domain.dart';

final class SignInUseCase implements FutureUseCase<User, SignInPayload> {
  final AuthRepository _authRepository;

  SignInUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<User> execute(SignInPayload input) async {
    return await _authRepository.signIn(input);
  }
}
