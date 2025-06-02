part of 'user_profile_bloc.dart';

abstract class UserProfileEvent {
  const UserProfileEvent();
}

final class InitUserProfile extends UserProfileEvent {
  const InitUserProfile();
}
