part of 'character_bloc.dart';

abstract class CharacterEvent {
  const CharacterEvent();
}

final class Init extends CharacterEvent {
  const Init();
}

final class LoadMore extends CharacterEvent {
  const LoadMore();
}

final class SearchCharacters extends CharacterEvent {
  final String query;

  const SearchCharacters({required this.query});
}

final class ResetSearch extends CharacterEvent {
  const ResetSearch();
}

final class AddCharacter extends CharacterEvent {
  final Character character;

  const AddCharacter({required this.character});
}

final class ChangeCharacterStatus extends CharacterEvent {
  final Status status;

  const ChangeCharacterStatus({required this.status});
}

final class NavigateToPreviousScreen extends CharacterEvent {
  const NavigateToPreviousScreen();
}
