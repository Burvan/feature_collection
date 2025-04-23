part of 'character_bloc.dart';

abstract class CharacterEvent {
  const CharacterEvent();
}

class Init extends CharacterEvent {
  const Init();
}

class LoadMore extends CharacterEvent {
  const LoadMore();
}

class SearchCharacters extends CharacterEvent {
  final String query;

  const SearchCharacters({required this.query});
}

class ResetSearch extends CharacterEvent {
  const ResetSearch();
}

class AddCharacter extends CharacterEvent {
  final Character character;

  const AddCharacter({required this.character});
}

class NavigateToPreviousScreen extends CharacterEvent {
  const NavigateToPreviousScreen();
}
