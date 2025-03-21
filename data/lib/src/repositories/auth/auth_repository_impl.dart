import 'package:core/core.dart';
import 'package:data/data.dart' as data;
import 'package:domain/domain.dart' as domain;

class AuthRepositoryImpl implements domain.AuthRepository {
  final data.AuthProvider _authProvider;
  final data.MapperFactory mapper;

  AuthRepositoryImpl({
    required data.AuthProvider authProvider,
    required this.mapper,
  }) : _authProvider = authProvider;

  @override
  Future<domain.User> signIn(domain.SignInPayload payload) async {
    final UserCredential userCredential = await _authProvider.signIn(
      email: payload.email,
      password: payload.password,
    );

    final data.UserEntity? userEntity =
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
  Future<domain.User> signUp(domain.SignUpPayload payload) async {
    final UserCredential userCredential = await _authProvider.signUp(
      email: payload.email,
      password: payload.password,
    );

    final data.UserEntity userEntity = data.UserEntity(
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
