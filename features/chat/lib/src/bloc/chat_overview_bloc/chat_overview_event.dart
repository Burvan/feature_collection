part of 'chat_overview_bloc.dart';

abstract class ChatOverviewEvent {
  const ChatOverviewEvent();
}

final class Init extends ChatOverviewEvent {
  const Init();
}

final class NavigateToChat extends ChatOverviewEvent {
  final String selectedUserId;
  final String fullName;
  final Uint8List? avatar;

  const NavigateToChat({
    required this.selectedUserId,
    required this.fullName,
    required this.avatar,
  });
}
