import 'package:domain/domain.dart';

final class AddCharacterUseCase extends FutureUseCase<void, Character> {
  final CharacterRepository _characterRepository;

  AddCharacterUseCase({
    required CharacterRepository characterRepository,
  }) : _characterRepository = characterRepository;

  @override
  Future<void> execute(Character input) async {
    await _characterRepository.addCharacter(input);
  }
}