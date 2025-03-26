import 'package:core/core.dart';
import 'package:data/data.dart';

class AuthProvider {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final ErrorHandler _errorHandler;

  AuthProvider({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
    required ErrorHandler errorHandler,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore,
        _errorHandler = errorHandler;

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw _errorHandler.handle(e);
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
    } catch (e) {
      throw _errorHandler.handle(e);
    }
  }

  Future<void> saveUserData(UserEntity user) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(user.id)
          .set(user.toJson());
    } catch (e) {
      throw _errorHandler.handle(e);
    }
  }

  Future<UserEntity?> fetchUserData({
    required String userId,
  }) async {
    try {
      final DocumentSnapshot snapshot =
          await _firebaseFirestore.collection('users').doc(userId).get();

      if (snapshot.exists) {
        return UserEntity.fromJson(snapshot.data() as Map<String, dynamic>);
      }

      return null;
    } catch (e) {
      throw _errorHandler.handle(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw _errorHandler.handle(e);
    }
  }
}
