import 'package:domain/domain.dart';

final class SignUpUseCase implements FutureUseCase<User, SignUpPayload> {
  final AuthRepository _authRepository;

  SignUpUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<User> execute(SignUpPayload input) async {
    return await _authRepository.signUp(input);
  }
}
