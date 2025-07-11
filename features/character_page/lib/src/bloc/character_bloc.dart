import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final FetchCharactersUseCase _fetchCharactersUseCase;
  final AddCharacterUseCase _addCharacterUseCase;
  final AppRouter _appRouter;

  CharacterBloc({
    required FetchCharactersUseCase fetchCharactersUseCase,
    required AddCharacterUseCase addCharacterUseCase,
    required AppRouter appRouter,
  })  : _fetchCharactersUseCase = fetchCharactersUseCase,
        _addCharacterUseCase = addCharacterUseCase,
        _appRouter = appRouter,
        super(const CharacterState.initial()) {
    on<Init>(_onInit);
    on<LoadMore>(_onLoadMore);
    on<SearchCharacters>(_onSearchCharacters);
    on<AddCharacter>(_onAddCharacter);
    on<ChangeCharacterStatus>(_onSetStatus);
    on<ResetSearch>(_onResetSearch);
    on<NavigateToPreviousScreen>(_onNavigateToPreviousScreen);

    add(const Init());
  }

  Future<void> _onInit(
    Init event,
    Emitter<CharacterState> emit,
  ) async {
    emit(
      state.copyWith(
        isPageLoading: true,
        exception: () => null,
        characters: const <Character>[],
      ),
    );

    try {
      final List<Character> characters = await _fetchCharactersUseCase.execute(
        const FetchCharactersParams.initial(),
      );

      emit(
        state.copyWith(
          characters: characters,
          isEndOfList: characters.length < AppConstants.charactersPerLoad,
          paginationCursor: () =>
              characters.isNotEmpty ? characters.last.id.toString() : null,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          exception: () => e,
          characters: const <Character>[],
        ),
      );
    } finally {
      emit(state.copyWith(isPageLoading: false));
    }
  }

  Future<void> _onLoadMore(
    LoadMore event,
    Emitter<CharacterState> emit,
  ) async {
    emit(state.copyWith(isCharactersLoading: true));

    try {
      final List<Character> newCharacters =
          await _fetchCharactersUseCase.execute(
        FetchCharactersParams.initial(
          query: state.query,
          paginationCursor: state.paginationCursor,
        ),
      );

      emit(
        state.copyWith(
          characters: List<Character>.of(state.characters)
            ..addAll(newCharacters),
          isEndOfList: newCharacters.isEmpty,
          paginationCursor: () => newCharacters.isNotEmpty
              ? newCharacters.last.id.toString()
              : null,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          exception: () => e,
        ),
      );
    } finally {
      emit(state.copyWith(isCharactersLoading: false));
    }
  }

  Future<void> _onSearchCharacters(
    SearchCharacters event,
    Emitter<CharacterState> emit,
  ) async {
    if (event.query == state.query) return;

    emit(
      state.copyWith(
        query: () => event.query,
        paginationCursor: () => null,
        exception: () => null,
        isEndOfList: false,
        isCharactersLoading: true,
      ),
    );

    try {
      final List<Character> characters = await _fetchCharactersUseCase.execute(
        FetchCharactersParams.initial(query: state.query),
      );

      emit(
        state.copyWith(
          characters: characters,
          isEndOfList: characters.length < AppConstants.charactersPerLoad,
          paginationCursor: () =>
          characters.isNotEmpty ? characters.last.id.toString() : null,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          exception: () => e,
        ),
      );
    } finally {
      emit(state.copyWith(isCharactersLoading: false));
    }

  }

  Future<void> _onResetSearch(
    ResetSearch event,
    Emitter<CharacterState> emit,
  ) async {
    emit(const CharacterState.initial());

    try {
      emit(state.copyWith(isCharactersLoading: true));

      final List<Character> characters = await _fetchCharactersUseCase.execute(
        FetchCharactersParams.initial(query: state.query),
      );

      emit(
        state.copyWith(
          characters: characters,
          isEndOfList: characters.length < AppConstants.charactersPerLoad,
          paginationCursor: () =>
          characters.isNotEmpty ? characters.last.id.toString() : null,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          exception: () => e,
        ),
      );
    } finally {
      emit(state.copyWith(isCharactersLoading: false));
    }

  }

  Future<void> _onAddCharacter(
    AddCharacter event,
    Emitter<CharacterState> emit,
  ) async {
    emit(state.copyWith(isCharactersLoading: true));

    try {
      await _addCharacterUseCase.execute(event.character);
      emit(
        state.copyWith(
          characters: <Character>[event.character, ...state.characters],
          status: Status.unknown,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          exception: () => e,
        ),
      );
    } finally {
      emit(state.copyWith(isCharactersLoading: false));
    }
  }

  Future<void> _onSetStatus(
    ChangeCharacterStatus event,
    Emitter<CharacterState> emit,
  ) async {
    emit(
      state.copyWith(status: event.status),
    );
  }

  Future<void> _onNavigateToPreviousScreen(
    NavigateToPreviousScreen event,
    Emitter<CharacterState> emit,
  ) async {
    await _appRouter.maybePop();
  }
}
