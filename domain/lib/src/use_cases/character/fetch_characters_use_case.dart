import 'package:domain/domain.dart';

final class FetchCharactersUseCase
    extends FutureUseCase<List<Character>, FetchCharactersParams> {
  final CharacterRepository _characterRepository;

  FetchCharactersUseCase({
    required CharacterRepository characterRepository,
  }) : _characterRepository = characterRepository;

  @override
  Future<List<Character>> execute(FetchCharactersParams input) async {
    return _characterRepository.fetchCharacters(input);
  }
}
