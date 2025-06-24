part of 'user_selection_bloc.dart';

abstract class UserSelectionEvent {
  const UserSelectionEvent();
}

final class Init extends UserSelectionEvent {
  const Init();
}

final class LoadMore extends UserSelectionEvent {
  const LoadMore();
}

final class NavigateToChat extends UserSelectionEvent {
  final String selectedUserId;
  final String fullName;
  final Uint8List? avatar;

  const NavigateToChat({
    required this.selectedUserId,
    required this.fullName,
    required this.avatar,
  });
}
