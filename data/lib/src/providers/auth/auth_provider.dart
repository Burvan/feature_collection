import 'package:core/core.dart';
import 'package:data/data.dart';

class AuthProvider {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  const AuthProvider({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AppException(
        type: AppExceptionType.firebaseAuthCodeError,
        message: e.code,
      );
    } catch (e) {
      throw AppException.unknown(message: e.toString());
    }
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AppException(
        type: AppExceptionType.firebaseAuthCodeError,
        message: e.code,
      );
    } catch (e) {
      throw AppException.unknown(message: e.toString());
    }
  }

  Future<void> saveUserData(UserEntity user) async {
    try {
      await _firebaseFirestore
          .collection(DataConstants.userCollection)
          .doc(user.id)
          .set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw AppException(
        type: AppExceptionType.firebaseAuthCodeError,
        message: e.code,
      );
    } catch (e) {
      throw AppException.unknown(message: e.toString());
    }
  }

  Future<UserEntity?> fetchUserData({
    required String userId,
  }) async {
    try {
      final DocumentSnapshot snapshot = await _firebaseFirestore
          .collection(DataConstants.userCollection)
          .doc(userId)
          .get();

      if (snapshot.exists) {
        return UserEntity.fromJson(snapshot.data()! as Map<String, dynamic>);
      }

      return null;
    } on FirebaseAuthException catch (e) {
      throw AppException(
        type: AppExceptionType.firebaseAuthCodeError,
        message: e.code,
      );
    } catch (e) {
      throw AppException.unknown(message: e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AppException.unknown(message: e.toString());
    }
  }
}
