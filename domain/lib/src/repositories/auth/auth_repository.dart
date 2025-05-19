part of repositories;

abstract interface class AuthRepository {
  Future<void> signUp(SignUpPayload payload);
  Future<void> signIn(SignInPayload payload);
  Future<void> signOut();
  Future<void> sendEmailVerification();
  Future<void> checkEmailVerification();
}
