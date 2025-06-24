part of 'chat_with_user_bloc.dart';

final class ChatWithUserState {
  final List<ChatMessage> messages;
  final bool isPageLoading;
  final bool isMessagesLoading;
  final bool isEndOfList;
  final AppException? exception;
  final String? paginationCursor;

  const ChatWithUserState({
    required this.messages,
    required this.isPageLoading,
    required this.isMessagesLoading,
    required this.isEndOfList,
    this.exception,
    this.paginationCursor,
  });

  const ChatWithUserState.initial()
      : messages = const <ChatMessage>[],
        isPageLoading = false,
        isMessagesLoading = false,
        isEndOfList = false,
        exception = null,
        paginationCursor = null;

  bool get hasException => exception != null;

  double get triggerOffset => 1 - (AppConstants.itemsPerLoad / messages.length);

  ChatWithUserState copyWith({
    List<ChatMessage>? messages,
    bool? isPageLoading,
    bool? isMessagesLoading,
    bool? isEndOfList,
    AppException? Function()? exception,
    String? Function()? paginationCursor,
  }) {
    return ChatWithUserState(
      messages: messages ?? this.messages,
      isPageLoading: isPageLoading ?? this.isPageLoading,
      isMessagesLoading: isMessagesLoading ?? this.isMessagesLoading,
      isEndOfList: isEndOfList ?? this.isEndOfList,
      exception: exception != null ? exception() : this.exception,
      paginationCursor:
          paginationCursor != null ? paginationCursor() : this.paginationCursor,
    );
  }
}
