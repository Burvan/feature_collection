part of providers;

final class FirebaseProvider {
  final FirebaseFirestore _firebaseFirestore;
  final ErrorHandler _errorHandler;

  const FirebaseProvider({
    required FirebaseFirestore firebaseFirestore,
    required ErrorHandler errorHandler,
  })  : _firebaseFirestore = firebaseFirestore,
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
      throw _errorHandler.handleError(e);
    }
  }

  Future<void> addCharacter(CharacterEntity entity) async {
    try {
      await _firebaseFirestore
          .collection(DataConstants.characterCollection)
          .add(entity.toJson());
    } catch (e) {
      throw _errorHandler.handleError(e);
    }
  }
}
