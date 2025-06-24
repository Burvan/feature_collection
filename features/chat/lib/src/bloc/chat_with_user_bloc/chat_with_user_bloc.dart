import 'dart:async';
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'chat_with_user_event.dart';
part 'chat_with_user_state.dart';

final class ChatWithUserBloc
    extends Bloc<ChatWithUserEvent, ChatWithUserState> {
  final FetchRecentMessagesUseCase _fetchRecentMessagesUseCase;
  final FetchOldMessagesUseCase _fetchOldMessagesUseCase;
  final FetchCurrentUserUseCase _fetchCurrentUserUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final String otherUserId;
  final String fullName;
  final Uint8List? avatar;

  StreamSubscription<List<ChatMessage>>? _messagesSubscription;

  ChatWithUserBloc({
    required FetchRecentMessagesUseCase fetchRecentMessagesUseCase,
    required FetchOldMessagesUseCase fetchOldMessagesUseCase,
    required SendMessageUseCase sendMessageUseCase,
    required FetchCurrentUserUseCase fetchCurrentUserUseCase,
    required this.otherUserId,
    required this.fullName,
    required this.avatar,
  })  : _fetchRecentMessagesUseCase = fetchRecentMessagesUseCase,
        _fetchOldMessagesUseCase = fetchOldMessagesUseCase,
        _fetchCurrentUserUseCase = fetchCurrentUserUseCase,
        _sendMessageUseCase = sendMessageUseCase,
        super(const ChatWithUserState.initial()) {
    on<Init>(_onInit);
    on<MessagesReceived>(_onMessagesReceived);
    on<LoadMore>(_onLoadMore);
    on<SendMessage>(_onSendMessage);

    add(const Init());
  }

  Future<void> _onInit(
    Init event,
    Emitter<ChatWithUserState> emit,
  ) async {
    emit(
      state.copyWith(
        isPageLoading: true,
        messages: const <ChatMessage>[],
        exception: () => null,
      ),
    );

    await _messagesSubscription?.cancel();

    try {
      final User currentUser = await _fetchCurrentUserUseCase.execute(
        const NoParams(),
      );

      _messagesSubscription = _fetchRecentMessagesUseCase
          .execute(
        ChatWithUserPayload(
          currentUserId: currentUser.id,
          otherUserId: otherUserId,
          paginationPayload: const PaginationPayload<String>.initial(),
        ),
      )
          .listen((List<ChatMessage> messages) {
        add(MessagesReceived(messages));
      });
    } on AppException catch (e) {
      emit(state.copyWith(exception: () => e));
    } finally {
      emit(state.copyWith(isPageLoading: false));
    }
  }

  Future<void> _onMessagesReceived(
    MessagesReceived event,
    Emitter<ChatWithUserState> emit,
  ) async {
    final List<ChatMessage> updatedMessages = <ChatMessage>[
      ...event.messages,
      ...state.messages,
    ];

    final List<ChatMessage> uniqueMessages = <String?, ChatMessage>{
      for (final ChatMessage msg in updatedMessages) msg.id: msg,
    }.values.toList();

    uniqueMessages.sort(
        (ChatMessage a, ChatMessage b) => b.timestamp.compareTo(a.timestamp));

    emit(
      state.copyWith(
        messages: uniqueMessages,
        isEndOfList:
            uniqueMessages.length <= AppConstants.itemsPerLoad ? true : false,
        paginationCursor: () =>
            state.paginationCursor ??
            (uniqueMessages.isNotEmpty ? uniqueMessages.last.id : null),
      ),
    );
  }

  Future<void> _onLoadMore(
    LoadMore event,
    Emitter<ChatWithUserState> emit,
  ) async {
    if (state.paginationCursor == null) return;

    emit(state.copyWith(isMessagesLoading: true));

    try {
      final User currentUser =
          await _fetchCurrentUserUseCase.execute(const NoParams());

      final List<ChatMessage> newMessages =
          await _fetchOldMessagesUseCase.execute(
        ChatWithUserPayload(
          currentUserId: currentUser.id,
          otherUserId: otherUserId,
          paginationPayload: PaginationPayload<String>(
            paginationCursor: state.paginationCursor,
            limit: 20,
          ),
        ),
      );

      final List<ChatMessage> allMessages =
          List<ChatMessage>.from(state.messages)..addAll(newMessages);
      allMessages.sort((
        ChatMessage a,
        ChatMessage b,
      ) =>
          b.timestamp.compareTo(a.timestamp));

      emit(
        state.copyWith(
          messages: allMessages,
          isEndOfList: newMessages.isEmpty,
          paginationCursor: () =>
              newMessages.isNotEmpty ? newMessages.last.id : null,
        ),
      );
    } on AppException catch (e) {
      emit(state.copyWith(exception: () => e));
    } finally {
      emit(state.copyWith(isMessagesLoading: false));
    }
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatWithUserState> emit,
  ) async {
    try {
      final User currentUser = await _fetchCurrentUserUseCase.execute(
        const NoParams(),
      );

      await _sendMessageUseCase.execute(
        ChatMessage(
          senderId: currentUser.id,
          receiverId: otherUserId,
          text: event.text,
          timestamp: DateTime.now(),
        ),
      );
    } on AppException catch (e) {
      emit(state.copyWith(exception: () => e));
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
