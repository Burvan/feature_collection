part of 'settings_bloc.dart';

class SettingsState {
  final bool isPageLoading;
  final ThemeData themeData;
  final bool isSystemTheme;
  final bool isDark;
  final Locale locale;
  final User user;
  final bool isEmailVerified;
  final AppException? exception;

  const SettingsState({
    required this.isPageLoading,
    required this.themeData,
    required this.isDark,
    required this.isSystemTheme,
    required this.locale,
    required this.user,
    required this.isEmailVerified,
    this.exception,
  });

  SettingsState.initial()
      : isPageLoading = false,
        themeData = AppTheme.lightTheme,
        isDark = false,
        isSystemTheme = false,
        locale = AppLocalization.fallbackLocale,
        user = User.empty(),
        isEmailVerified = true,
        exception = null;

  SettingsState copyWith({
    bool? isPageLoading,
    ThemeData? themeData,
    bool? isDark,
    bool? isSystemTheme,
    Locale? locale,
    User? user,
    bool? isEmailVerified,
    AppException? Function()? exception,
  }) {
    return SettingsState(
      isPageLoading: isPageLoading ?? this.isPageLoading,
      themeData: themeData ?? this.themeData,
      isDark: isDark ?? this.isDark,
      isSystemTheme: isSystemTheme ?? this.isSystemTheme,
      locale: locale ?? this.locale,
      user: user ?? this.user,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      exception: exception != null ? exception() : this.exception,
    );
  }
}
