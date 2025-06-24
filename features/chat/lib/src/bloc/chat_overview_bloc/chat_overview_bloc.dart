import 'dart:async';
import 'dart:typed_data';

import 'package:chat/chat.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'chat_overview_event.dart';
part 'chat_overview_state.dart';

final class ChatOverviewBloc
    extends Bloc<ChatOverviewEvent, ChatOverviewState> {
  final FetchChatOverviewsUseCase _fetchChatOverviewsUseCase;
  final FetchCurrentUserUseCase _fetchCurrentUserUseCase;
  final AppRouter _appRouter;

  StreamSubscription<List<ChatOverview>>? _chatSubscription;

  ChatOverviewBloc({
    required FetchChatOverviewsUseCase fetchChatOverviewsUseCase,
    required FetchCurrentUserUseCase fetchCurrentUserUseCase,
    required AppRouter appRouter,
  })  : _fetchChatOverviewsUseCase = fetchChatOverviewsUseCase,
        _fetchCurrentUserUseCase = fetchCurrentUserUseCase,
        _appRouter = appRouter,
        super(const ChatOverviewState.initial()) {
    on<Init>(_onInit);
    on<NavigateToChat>(_onNavigateToChat);

    add(const Init());
  }

  Future<void> _onInit(
    Init event,
    Emitter<ChatOverviewState> emit,
  ) async {
    emit(
      state.copyWith(
        isPageLoading: true,
        exception: () => null,
      ),
    );

    await _chatSubscription?.cancel();

    try {
      final User currentUser =
          await _fetchCurrentUserUseCase.execute(const NoParams());

      final Stream<List<ChatOverview>> stream =
          _fetchChatOverviewsUseCase.execute(
        ChatOverviewPayload(currentUserId: currentUser.id),
      );

      await emit.onEach<List<ChatOverview>>(
        stream,
        onData: (List<ChatOverview> chats) {
          emit(
            state.copyWith(
              chats: chats,
              isPageLoading: false,
            ),
          );
        },
        onError: (Object error, StackTrace stackTrace) {
          if (error is AppException) {
            emit(
              state.copyWith(
                exception: () => error,
                isPageLoading: false,
              ),
            );
          }
        },
      );
    } on AppException catch (e) {
      emit(state.copyWith(exception: () => e));
    }
  }

  Future<void> _onNavigateToChat(
    NavigateToChat event,
    Emitter<ChatOverviewState> emit,
  ) async {
    try {
      final User currentUser =
          await _fetchCurrentUserUseCase.execute(const NoParams());

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
