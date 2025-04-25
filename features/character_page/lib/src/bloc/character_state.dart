part of 'character_bloc.dart';

class CharacterState extends Equatable {
  final List<Character> characters;
  final bool isLoading;
  final bool isEndOfList;
  final AppException? exception;
  final String? query;
  final String? paginationCursor;

  const CharacterState({
    required this.characters,
    required this.isLoading,
    required this.isEndOfList,
    this.exception,
    this.query,
    this.paginationCursor,
  });

  const CharacterState.initial()
      : characters = const <Character>[],
        isLoading = false,
        isEndOfList = false,
        exception = null,
        query = null,
        paginationCursor = null;

  bool get hasException => exception != null;

  CharacterState copyWith({
    List<Character>? characters,
    bool? isLoading,
    bool? isEndOfList,
    AppException? Function()? exception,
    String? Function()? query,
    String? Function()? paginationCursor,
  }) {
    return CharacterState(
      characters: characters ?? this.characters,
      isLoading: isLoading ?? this.isLoading,
      isEndOfList: isEndOfList ?? this.isEndOfList,
      exception: exception != null ? exception() : this.exception,
      query: query != null ? query() : this.query,
      paginationCursor:
          paginationCursor != null ? paginationCursor() : this.paginationCursor,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        characters,
        isLoading,
        isEndOfList,
        exception,
        query,
        paginationCursor,
      ];
}
