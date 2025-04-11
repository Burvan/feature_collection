import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';

class FirebaseProvider {
  final FirebaseFirestore _firebaseFirestore;

  const FirebaseProvider({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  Future<List<CharacterEntity>> fetchCharacters(
    FetchCharactersParams params,
  ) async {
    try {
      Query<Map<String, dynamic>> queryRef = _firebaseFirestore
          .collection(AppConstants.characterCollection)
          .orderBy(AppConstants.name)
          .limit(params.limit);

      if (params.paginationCursor != null) {
        final DocumentSnapshot<Map<String, dynamic>> lastDoc =
            await _firebaseFirestore
                .doc(
                  '${AppConstants.characterCollection}/${params.paginationCursor}',
                )
                .get();
        queryRef = queryRef.startAfterDocument(lastDoc);
      }

      if (params.query != null) {
        queryRef = queryRef
            .where(AppConstants.name, isGreaterThanOrEqualTo: params.query)
            .where(AppConstants.name, isLessThan: '${params.query}z');
      }

      final QuerySnapshot<Map<String, dynamic>> snapshot = await queryRef.get();

      return snapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        final Map<String, dynamic> data = doc.data();
        if (!data.containsKey(AppConstants.idKey)) {
          data[AppConstants.idKey] = int.parse(doc.id);
        }
        return CharacterEntity.fromJson(data);
      }).toList();

    } on FirebaseException catch (e) {
      throw AppException(
        type: AppExceptionType.firestoreCodeError,
        message: e.code,
      );
    } catch (e) {
      throw AppException.unknown(message: e.toString());
    }
  }

  Future<void> addCharacter(CharacterEntity entity) async {
    try {
      await _firebaseFirestore
          .collection(AppConstants.characterCollection)
          .add(entity.toJson());

    } on FirebaseException catch (e) {
      throw AppException(
        type: AppExceptionType.firestoreCodeError,
        message: e.code,
      );
    } catch (e) {
      throw AppException.unknown(message: e.toString());
    }
  }
}
