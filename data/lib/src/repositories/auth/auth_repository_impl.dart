import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthProvider _authProvider;
  final MapperFactory mapper;

  AuthRepositoryImpl({
    required AuthProvider authProvider,
    required this.mapper,
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
      throw FirestoreException(message: 'User data not found');
    }

    return mapper.userMapper.fromEntity(userEntity);
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
      gender: payload.gender,
      phoneNumber: payload.phoneNumber,
      email: payload.email,
      password: payload.password,
    );

    await _authProvider.saveUserData(userEntity);
    return mapper.userMapper.fromEntity(userEntity);
  }
}
