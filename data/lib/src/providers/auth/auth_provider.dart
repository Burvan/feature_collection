part of providers;

final class AuthProvider {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final ErrorHandler _errorHandler;

  const AuthProvider({
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
      _errorHandler.handleError(e);
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
      _errorHandler.handleError(e);
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      if (_firebaseAuth.currentUser != null) {
        await _firebaseAuth.currentUser?.sendEmailVerification();
      }
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }

  Future<bool> checkEmailVerification() async {
    try {
      await _firebaseAuth.currentUser?.reload();

      final bool isVerified = _firebaseAuth.currentUser?.emailVerified ?? false;

      if (!isVerified) {
        throw AppException(type: AppExceptionType.emailNotVerified);
      }

      return isVerified;
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }

  Future<void> saveUserData(UserEntity user) async {
    try {
      await _firebaseFirestore
          .collection(DataConstants.userCollection)
          .doc(user.id)
          .set(user.toJson());
    } catch (e) {
      _errorHandler.handleError(e);
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
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }
}
