part of 'user_selection_bloc.dart';

final class UserSelectionState {
  final List<User> users;
  final bool isLoading;
  final bool isEndOfList;
  final AppException? exception;
  final String? paginationCursor;

  const UserSelectionState({
    required this.users,
    required this.isLoading,
    required this.isEndOfList,
    this.exception,
    this.paginationCursor,
  });

  const UserSelectionState.initial()
      : users = const <User>[],
        isLoading = false,
        isEndOfList = false,
        exception = null,
        paginationCursor = null;

  bool get hasException => exception != null;

  double get triggerOffset => 1 - (AppConstants.itemsPerLoad / users.length);

  UserSelectionState copyWith({
    List<User>? users,
    bool? isLoading,
    bool? isEndOfList,
    AppException? Function()? exception,
    String? Function()? paginationCursor,
  }) {
    return UserSelectionState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      isEndOfList: isEndOfList ?? this.isEndOfList,
      exception: exception != null ? exception() : this.exception,
      paginationCursor:
          paginationCursor != null ? paginationCursor() : this.paginationCursor,
    );
  }
}
