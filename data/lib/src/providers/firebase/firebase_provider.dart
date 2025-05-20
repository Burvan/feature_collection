part of providers;

final class FirebaseProvider {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  final ErrorHandler _errorHandler;

  const FirebaseProvider({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseAuth firebaseAuth,
    required ErrorHandler errorHandler,
  })  : _firebaseFirestore = firebaseFirestore,
        _firebaseAuth = firebaseAuth,
        _errorHandler = errorHandler;

  Future<List<CharacterEntity>> fetchCharacters(
    FetchCharactersParams params,
  ) async {
    try {
      Query<Map<String, dynamic>> queryRef = _firebaseFirestore
          .collection(DataConstants.characterCollection)
          .orderBy(DataConstants.name)
          .limit(params.limit);

      if (params.paginationCursor != null) {
        final DocumentSnapshot<Map<String, dynamic>> lastDoc =
            await _firebaseFirestore
                .doc(
                  '${DataConstants.characterCollection}/${params.paginationCursor}',
                )
                .get();
        queryRef = queryRef.startAfterDocument(lastDoc);
      }

      if (params.query != null) {
        queryRef = queryRef
            .where(DataConstants.name, isGreaterThanOrEqualTo: params.query)
            .where(DataConstants.name, isLessThan: '${params.query}z');
      }

      final QuerySnapshot<Map<String, dynamic>> snapshot = await queryRef.get();

      return snapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        final Map<String, dynamic> data = doc.data();
        if (!data.containsKey(DataConstants.idKey)) {
          data[DataConstants.idKey] = int.parse(doc.id);
        }
        return CharacterEntity.fromJson(data);
      }).toList();
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }

  Future<void> addCharacter(CharacterEntity entity) async {
    try {
      await _firebaseFirestore
          .collection(DataConstants.characterCollection)
          .add(entity.toJson());
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }

  Future<UserEntity> getCurrentUser() async {
    try {
      final firebase_auth.User? user = _firebaseAuth.currentUser;

      final DocumentSnapshot<Map<String, dynamic>> doc =
          await _firebaseFirestore
              .collection(DataConstants.userCollection)
              .doc(user?.uid)
              .get();

      final UserEntity entity = UserEntity.fromJson(doc.data()!);

      return entity;
    } catch (e) {
      _errorHandler.handleError(e);
    }
  }

  Future<void> changeUserData(User user) async {
    try {
      final UserEntity entity = MapperFactory.userMapper.toEntity(user);
      final firebase_auth.User? currentUser = _firebaseAuth.currentUser;

      await _firebaseFirestore
          .collection(DataConstants.userCollection)
          .doc(currentUser?.uid)
          .update(entity.toJson());

      if (currentUser?.email != entity.email) {
        await currentUser?.verifyBeforeUpdateEmail(entity.email);
      }
    } catch (e) {
      AppLogger.error(e.toString());
      _errorHandler.handleError(e);
    }
  }

  Future<bool> checkEmailConsistency() async {
    final firebase_auth.User? user = _firebaseAuth.currentUser;

    final DocumentSnapshot<Map<String, dynamic>> doc = await _firebaseFirestore
        .collection(DataConstants.userCollection)
        .doc(user?.uid)
        .get();

    final String storedEmail = doc.data()?[DataConstants.emailKey];

    return user?.email == storedEmail;
  }
}
