part of 'character_bloc.dart';

class CharacterState extends Equatable {
  final List<Character> characters;
  final bool isLoading;
  final bool isEndOfList;
  final String? errorMessage;
  final String? query;
  final String? paginationCursor;

  const CharacterState({
    required this.characters,
    required this.isLoading,
    required this.isEndOfList,
    this.errorMessage,
    this.query,
    this.paginationCursor,
  });

  const CharacterState.initial()
      : characters = const <Character>[],
        isLoading = false,
        isEndOfList = false,
        errorMessage = null,
        query = null,
        paginationCursor = null;

  CharacterState copyWith({
    List<Character>? characters,
    bool? isLoading,
    bool? isEndOfList,
    String? errorMessage,
    String? query,
    String? paginationCursor,
  }) {
    return CharacterState(
      characters: characters ?? this.characters,
      isLoading: isLoading ?? this.isLoading,
      isEndOfList: isEndOfList ?? this.isEndOfList,
      errorMessage: errorMessage ?? this.errorMessage,
      query: query ?? this.query,
      paginationCursor: paginationCursor ?? this.paginationCursor,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        characters,
        isLoading,
        isEndOfList,
        errorMessage,
        query,
        paginationCursor,
      ];
}
