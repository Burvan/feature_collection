part of repositories;

abstract interface class CharacterRepository {
  Future<List<Character>> fetchCharacters(PaginationPayload payload);
  Future<void> addCharacter(Character character);
}
