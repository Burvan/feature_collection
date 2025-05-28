part of 'user_profile_bloc.dart';

class UserProfileState {
  final bool isPageLoading;
  final User user;
  final AppException? exception;

  const UserProfileState({
    required this.isPageLoading,
    required this.user,
    this.exception,
  });

  UserProfileState.initial()
      : isPageLoading = false,
        user = User.empty(),
        exception = null;

  UserProfileState copyWith({
    bool? isPageLoading,
    User? user,
    AppException? Function()? exception,
  }) {
    return UserProfileState(
      isPageLoading: isPageLoading ?? this.isPageLoading,
      user: user ?? this.user,
      exception: exception != null ? exception() : this.exception,
    );
  }
}
