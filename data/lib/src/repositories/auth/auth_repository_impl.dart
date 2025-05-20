part of repositories;

class AuthRepositoryImpl implements AuthRepository {
  final AuthProvider _authProvider;

  const AuthRepositoryImpl({
    required AuthProvider authProvider,
  }) : _authProvider = authProvider;

  @override
  Future<void> signIn(SignInPayload payload) async {
    await _authProvider.signIn(
      email: payload.email,
      password: payload.password,
    );
  }

  @override
  Future<void> signOut() async {
    await _authProvider.signOut();
  }

  @override
  Future<void> signUp(SignUpPayload payload) async {
    final UserCredential userCredential = await _authProvider.signUp(
      email: payload.email,
      password: payload.password,
    );

    final UserEntity userEntity = UserEntity(
      id: userCredential.user!.uid,
      firstName: payload.firstName,
      lastName: payload.lastName,
      dateOfBirth: payload.dateOfBirth,
      gender: payload.gender.label,
      phoneNumber: payload.phoneNumber,
      email: payload.email,
      password: payload.password,
    );

    await _authProvider.saveUserData(userEntity);
  }

  @override
  Future<void> sendEmailVerification() async {
    await _authProvider.sendEmailVerification();
  }

  @override
  Future<void> checkEmailVerification() async {
    await _authProvider.checkEmailVerification();
  }
}
