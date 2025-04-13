import 'package:data/data.dart';
import 'package:domain/domain.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final FirebaseProvider _firebaseProvider;

  CharacterRepositoryImpl({
    required FirebaseProvider firebaseProvider,
  }) : _firebaseProvider = firebaseProvider;

  @override
  Future<void> addCharacter(Character character) async {
    final CharacterEntity entity =
        MapperFactory.characterMapper.toEntity(character);
    await _firebaseProvider.addCharacter(entity);
  }

  @override
  Future<List<Character>> fetchCharacters(FetchCharactersParams params) async {
    final List<CharacterEntity> entities =
        await _firebaseProvider.fetchCharacters(params);

    return entities
        .map((CharacterEntity entity) =>
            MapperFactory.characterMapper.fromEntity(entity))
        .toList();
  }
}
