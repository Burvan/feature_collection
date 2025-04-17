part of 'character_bloc.dart';

abstract class CharacterEvent {
  const CharacterEvent();
}

class InitEvent extends CharacterEvent {
  const InitEvent();
}

class FetchCharactersEvent extends CharacterEvent {
  const FetchCharactersEvent();
}

class SearchCharactersEvent extends CharacterEvent {
  final String query;

  const SearchCharactersEvent({required this.query});
}

class ResetSearchEvent extends CharacterEvent {
  const ResetSearchEvent();
}

class AddCharacterEvent extends CharacterEvent {
  final Character character;

  const AddCharacterEvent({required this.character});
}

class NavigateToPreviousScreenEvent extends CharacterEvent {
  const NavigateToPreviousScreenEvent();
}
