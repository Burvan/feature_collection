part of 'settings_bloc.dart';

abstract class SettingsEvent {
  const SettingsEvent();
}

final class InitSettings extends SettingsEvent {
  const InitSettings();
}

final class GetUserData extends SettingsEvent {
  const GetUserData();
}

final class ChangeThemeType extends SettingsEvent {
  final bool isSystemTheme;

  const ChangeThemeType({required this.isSystemTheme});
}

final class ChangeThemeMode extends SettingsEvent {
  final bool isDark;

  const ChangeThemeMode({required this.isDark});
}

final class ChangeLocale extends SettingsEvent {
  final Locale locale;

  const ChangeLocale({required this.locale});
}

final class ChangeUserData extends SettingsEvent {
  final String firstName;
  final String lastName;
  final String email;
  final Uint8List? avatar;

  const ChangeUserData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });
}

final class NavigateToEditProfileScreen extends SettingsEvent {
  const NavigateToEditProfileScreen();
}

final class NavigateToUserProfileScreen extends SettingsEvent {
  const NavigateToUserProfileScreen();
}

final class NavigateToPreviousScreen extends SettingsEvent {
  const NavigateToPreviousScreen();
}
