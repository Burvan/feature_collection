import 'package:domain/domain.dart';

abstract interface class CharacterRepository {
  Future<List<Character>> fetchCharacters(FetchCharactersParams params);
  Future<void> addCharacter(Character character);
}