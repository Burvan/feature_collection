import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthProvider _authProvider;

  AuthRepositoryImpl({
    required AuthProvider authProvider,
  }) : _authProvider = authProvider;

  @override
  Future<User> signIn(SignInPayload payload) async {
    final UserCredential userCredential = await _authProvider.signIn(
      email: payload.email,
      password: payload.password,
    );

    final UserEntity? userEntity =
        await _authProvider.fetchUserData(userId: userCredential.user!.uid);

    if (userEntity == null) {
      throw AppException(
        type: AppExceptionType.firebaseAuthCodeError,
        message: FirebaseCodeErrorMessage.userNotFound,
      );
    }

    return MapperFactory.userMapper.fromEntity(userEntity);
  }

  @override
  Future<void> signOut() async {
    await _authProvider.signOut();
  }

  @override
  Future<User> signUp(SignUpPayload payload) async {
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
    return MapperFactory.userMapper.fromEntity(userEntity);
  }
}
