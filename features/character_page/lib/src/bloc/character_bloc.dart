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
        super(const CharacterState.empty()) {
    on<InitEvent>(_onInit);
    on<FetchCharactersEvent>(_onFetchCharacters);
    on<SearchCharactersEvent>(_onSearchCharacters);
    on<AddCharacterEvent>(_onAddCharacter);
    on<ResetSearchEvent>(_onResetSearch);
    on<NavigateToPreviousScreenEvent>(_onNavigateToPreviousScreen);

    add(const InitEvent());
  }

  Future<void> _onInit(
    InitEvent event,
    Emitter<CharacterState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
        characters: const <Character>[],
      ),
    );

    try {
      final List<Character> characters = await _fetchCharactersUseCase.execute(
        FetchCharactersParams(query: state.query),
      );

      emit(
        state.copyWith(
          characters: characters,
          isLoading: false,
          paginationCursor:
              characters.isNotEmpty ? characters.last.id.toString() : null,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toLocalizedText(),
          characters: e.type == AppExceptionType.noSuchCharactersError
              ? const <Character>[]
              : state.characters,
          isEndOfList: e.type == AppExceptionType.noSuchCharactersError,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: AppException.unknown(
            message: e.toString(),
          ).toLocalizedText(),
        ),
      );
    }
  }

  Future<void> _onFetchCharacters(
    FetchCharactersEvent event,
    Emitter<CharacterState> emit,
  ) async {
    if (state.isEndOfList || state.isLoading) return;
    emit(state.copyWith(isLoading: true));

    try {
      final List<Character> newCharacters =
          await _fetchCharactersUseCase.execute(
        FetchCharactersParams(
          query: state.query,
          paginationCursor: state.paginationCursor,
        ),
      );

      emit(
        state.copyWith(
          characters: List<Character>.of(state.characters)
            ..addAll(newCharacters),
          isLoading: false,
          isEndOfList: newCharacters.isEmpty,
          paginationCursor: newCharacters.isNotEmpty
              ? newCharacters.last.id.toString()
              : null,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toLocalizedText(),
          isEndOfList: e.type == AppExceptionType.noSuchCharactersError,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: AppException.unknown(
            message: e.toString(),
          ).toLocalizedText(),
        ),
      );
    }
  }

  Future<void> _onSearchCharacters(
    SearchCharactersEvent event,
    Emitter<CharacterState> emit,
  ) async {
    if (event.query == state.query) return;

    emit(
      state.copyWith(
        query: event.query,
        paginationCursor: null,
        errorMessage: null,
        isEndOfList: false,
      ),
    );

    add(const InitEvent());
  }

  Future<void> _onResetSearch(
    ResetSearchEvent event,
    Emitter<CharacterState> emit,
  ) async {
    emit(const CharacterState.empty());
  }

  Future<void> _onAddCharacter(
    AddCharacterEvent event,
    Emitter<CharacterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      await _addCharacterUseCase.execute(event.character);
      emit(
        state.copyWith(
          isLoading: false,
          characters: <Character>[event.character, ...state.characters],
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toLocalizedText(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: AppException.unknown(
            message: e.toString(),
          ).toLocalizedText(),
        ),
      );
    }
  }

  Future<void> _onNavigateToPreviousScreen(
    NavigateToPreviousScreenEvent event,
    Emitter<CharacterState> emit,
  ) async {
    await _appRouter.maybePop();
  }
}
