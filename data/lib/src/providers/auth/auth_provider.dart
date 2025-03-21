import 'package:core/core.dart';
import 'package:data/data.dart';

class AuthProvider {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthProvider({
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
      throw AuthException(message: e.message ?? 'Failed to sign in');
    } catch (e) {
      throw AuthException(message: 'An unexpected error occurred');
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
      throw AuthException(message: e.message ?? 'Failed to sign up');
    } catch (e) {
      throw AuthException(message: 'An unexpected error occurred');
    }
  }

  Future<void> saveUserData(UserEntity user) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(user.id)
          .set(user.toJson());
    } on FirebaseException catch (e) {
      throw FirestoreException(
          message: e.message ?? 'Failed to save user data');
    } catch (e) {
      throw FirestoreException(message: 'An unexpected error occurred');
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
    } on FirebaseException catch (e) {
      throw FirestoreException(
        message: e.message ?? 'Failed to fetch user data',
      );
    } catch (e) {
      throw FirestoreException(message: 'An unexpected error occurred');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? 'Failed to sign out');
    } catch (e) {
      throw AuthException(message: 'An unexpected error occurred');
    }
  }
}
