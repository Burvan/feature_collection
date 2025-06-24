import 'dart:typed_data';

import 'package:chat/chat.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'user_selection_event.dart';
part 'user_selection_state.dart';

final class UserSelectionBloc
    extends Bloc<UserSelectionEvent, UserSelectionState> {
  final FetchUsersUseCase _fetchUsersUseCase;
  final FetchCurrentUserUseCase _fetchCurrentUserUseCase;
  final AppRouter _appRouter;

  UserSelectionBloc({
    required FetchUsersUseCase fetchUsersUseCase,
    required FetchCurrentUserUseCase fetchCurrentUserUseCase,
    required AppRouter appRouter,
  })  : _fetchUsersUseCase = fetchUsersUseCase,
        _fetchCurrentUserUseCase = fetchCurrentUserUseCase,
        _appRouter = appRouter,
        super(const UserSelectionState.initial()) {
    on<Init>(_onInit);
    on<LoadMore>(_onLoadMore);
    on<NavigateToChat>(_onNavigateToChat);

    add(const Init());
  }

  Future<void> _onInit(
    Init event,
    Emitter<UserSelectionState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        users: const <User>[],
        exception: () => null,
      ),
    );

    try {
      final List<User> users = await _fetchUsersUseCase.execute(
        const PaginationPayload<String>.initial(),
      );

      emit(
        state.copyWith(
          users: users,
          isEndOfList: users.length < AppConstants.itemsPerLoad,
          paginationCursor: () => users.isNotEmpty ? users.last.id : null,
        ),
      );
    } on AppException catch (e) {
      emit(state.copyWith(exception: () => e));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onLoadMore(
    LoadMore event,
    Emitter<UserSelectionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final List<User> newUsers = await _fetchUsersUseCase.execute(
        PaginationPayload<String>.initial(
          paginationCursor: state.paginationCursor,
        ),
      );

      emit(
        state.copyWith(
          users: List<User>.of(state.users)..addAll(newUsers),
          isEndOfList: newUsers.isEmpty,
          paginationCursor: () => newUsers.isNotEmpty ? newUsers.last.id : null,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          exception: () => e,
        ),
      );
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onNavigateToChat(
    NavigateToChat event,
    Emitter<UserSelectionState> emit,
  ) async {
    try {
      final User currentUser = await _fetchCurrentUserUseCase.execute(
        const NoParams(),
      );

      await _appRouter.push(
        ChatRoute(
          chatId: _generateChatId(currentUser.id, event.selectedUserId),
          otherUserId: event.selectedUserId,
          fullName: event.fullName,
          avatar: event.avatar,
        ),
      );
    } on AppException catch (e) {
      emit(state.copyWith(exception: () => e));
    }
  }

  String _generateChatId(String a, String b) {
    final List<String> sorted = <String>[a, b]..sort();
    return '${sorted[0]}_${sorted[1]}';
  }
}
