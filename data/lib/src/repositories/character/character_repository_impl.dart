part of repositories;

final class CharacterRepositoryImpl implements CharacterRepository {
  final FirebaseProvider _firebaseProvider;

  const CharacterRepositoryImpl({
    required FirebaseProvider firebaseProvider,
  }) : _firebaseProvider = firebaseProvider;

  @override
  Future<void> addCharacter(Character character) async {
    final CharacterEntity entity =
        MapperFactory.characterMapper.toEntity(character);
    await _firebaseProvider.addCharacter(entity);
  }

  @override
  Future<List<Character>> fetchCharacters(PaginationPayload params) async {
    final List<CharacterEntity> entities =
        await _firebaseProvider.fetchCharacters(params);

    return entities
        .map((CharacterEntity entity) =>
            MapperFactory.characterMapper.fromEntity(entity))
        .toList();
  }
}
