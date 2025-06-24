part of use_cases;

final class FetchCharactersUseCase
    implements FutureUseCase<List<Character>, PaginationPayload> {
  final CharacterRepository _characterRepository;

  const FetchCharactersUseCase({
    required CharacterRepository characterRepository,
  }) : _characterRepository = characterRepository;

  @override
  Future<List<Character>> execute(PaginationPayload input) async {
    return _characterRepository.fetchCharacters(input);
  }
}
