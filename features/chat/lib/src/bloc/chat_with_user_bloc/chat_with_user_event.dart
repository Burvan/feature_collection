part of 'chat_with_user_bloc.dart';

abstract class ChatWithUserEvent {
  const ChatWithUserEvent();
}

final class Init extends ChatWithUserEvent {
  const Init();
}

final class LoadMore extends ChatWithUserEvent {
  const LoadMore();
}

final class SendMessage extends ChatWithUserEvent {
  final String text;

  const SendMessage({required this.text});
}

final class MessagesReceived extends ChatWithUserEvent {
  final List<ChatMessage> messages;

  const MessagesReceived(this.messages);
}
