part of 'character_bloc.dart';

class CharacterState extends Equatable {
  final List<Character> characters;
  final bool isPageLoading;
  final bool isCharactersLoading;
  final bool isEndOfList;
  final AppException? exception;
  final String? query;
  final String? paginationCursor;
  final Status status;

  const CharacterState({
    required this.characters,
    required this.isPageLoading,
    required this.isCharactersLoading,
    required this.isEndOfList,
    this.exception,
    this.query,
    this.paginationCursor,
    this.status = Status.unknown,
  });

  const CharacterState.initial()
      : characters = const <Character>[],
        isPageLoading = false,
        isCharactersLoading = false,
        isEndOfList = false,
        exception = null,
        query = null,
        paginationCursor = null,
        status = Status.unknown;

  bool get hasException => exception != null;

  double get triggerOffset =>
      1 - (AppConstants.itemsPerLoad / characters.length);

  CharacterState copyWith({
    List<Character>? characters,
    bool? isPageLoading,
    bool? isCharactersLoading,
    bool? isEndOfList,
    AppException? Function()? exception,
    String? Function()? query,
    String? Function()? paginationCursor,
    Status? status,
  }) {
    return CharacterState(
      characters: characters ?? this.characters,
      isPageLoading: isPageLoading ?? this.isPageLoading,
      isCharactersLoading: isCharactersLoading ?? this.isCharactersLoading,
      isEndOfList: isEndOfList ?? this.isEndOfList,
      exception: exception != null ? exception() : this.exception,
      query: query != null ? query() : this.query,
      paginationCursor:
          paginationCursor != null ? paginationCursor() : this.paginationCursor,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        characters,
        isPageLoading,
        isCharactersLoading,
        isEndOfList,
        exception,
        query,
        paginationCursor,
        status,
      ];
}
