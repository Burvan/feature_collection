import 'package:domain/domain.dart';

abstract interface class AuthRepository {
  Future<User> signUp(SignUpPayload payload);
  Future<User> signIn(SignInPayload payload);
  Future<void> signOut();
}