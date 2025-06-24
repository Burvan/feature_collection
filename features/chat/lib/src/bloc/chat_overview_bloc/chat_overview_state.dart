part of 'chat_overview_bloc.dart';

final class ChatOverviewState {
  final List<ChatOverview> chats;
  final bool isPageLoading;
  final AppException? exception;

  const ChatOverviewState({
    required this.chats,
    required this.isPageLoading,
    this.exception,
  });

  const ChatOverviewState.initial()
      : chats = const <ChatOverview>[],
        isPageLoading = false,
        exception = null;

  bool get hasException => exception != null;

  ChatOverviewState copyWith({
    List<ChatOverview>? chats,
    bool? isPageLoading,
    AppException? Function()? exception,
  }) {
    return ChatOverviewState(
      chats: chats ?? this.chats,
      isPageLoading: isPageLoading ?? this.isPageLoading,
      exception: exception != null ? exception() : this.exception,
    );
  }
}
