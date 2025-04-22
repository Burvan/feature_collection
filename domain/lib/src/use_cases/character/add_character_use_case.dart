part of use_cases;

final class AddCharacterUseCase implements FutureUseCase<void, Character> {
  final CharacterRepository _characterRepository;

  const AddCharacterUseCase({
    required CharacterRepository characterRepository,
  }) : _characterRepository = characterRepository;

  @override
  Future<void> execute(Character input) async {
    await _characterRepository.addCharacter(input);
  }
}