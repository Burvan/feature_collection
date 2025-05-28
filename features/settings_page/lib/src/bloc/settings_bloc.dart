import 'dart:typed_data';
import 'dart:ui';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:settings_page/settings_page.dart';
import 'package:user_profile/user_profile.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ChangeThemeTypeUseCase _changeThemeTypeUseCase;
  final FetchCurrentThemeTypeUseCase _getCurrentThemeTypeUseCase;
  final ChangeThemeModeUseCase _changeThemeModeUseCase;
  final FetchCurrentThemeModeUseCase _getCurrentThemeModeUseCase;
  final ChangeLocaleUseCase _changeLocaleUseCase;
  final FetchCurrentLocaleUseCase _getCurrentLocaleUseCase;
  final FetchCurrentUserUseCase _getCurrentUserUseCase;
  final ChangeUserDataUseCase _changeUserDataUseCase;
  final CheckEmailConsistencyUseCase _checkEmailConsistencyUseCase;
  final AppRouter _appRouter;

  SettingsBloc({
    required ChangeThemeTypeUseCase changeThemeTypeUseCase,
    required FetchCurrentThemeTypeUseCase getCurrentThemeTypeUseCase,
    required ChangeThemeModeUseCase changeThemeModeUseCase,
    required FetchCurrentThemeModeUseCase getCurrentThemeModeUseCase,
    required ChangeLocaleUseCase changeLocaleUseCase,
    required FetchCurrentLocaleUseCase getCurrentLocaleUseCase,
    required FetchCurrentUserUseCase getCurrentUserUseCase,
    required ChangeUserDataUseCase changeUserDataUseCase,
    required CheckEmailConsistencyUseCase checkEmailConsistencyUseCase,
    required AppRouter appRouter,
  })  : _changeThemeTypeUseCase = changeThemeTypeUseCase,
        _getCurrentThemeTypeUseCase = getCurrentThemeTypeUseCase,
        _changeThemeModeUseCase = changeThemeModeUseCase,
        _getCurrentThemeModeUseCase = getCurrentThemeModeUseCase,
        _changeLocaleUseCase = changeLocaleUseCase,
        _getCurrentLocaleUseCase = getCurrentLocaleUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        _changeUserDataUseCase = changeUserDataUseCase,
        _checkEmailConsistencyUseCase = checkEmailConsistencyUseCase,
        _appRouter = appRouter,
        super(SettingsState.initial()) {
    on<InitSettings>(_onInitSettings);
    on<GetUserData>(_onGetUserData);
    on<ChangeThemeType>(_onChangeThemeType);
    on<ChangeThemeMode>(_onChangeThemeMode);
    on<ChangeLocale>(_onChangeLocale);
    on<ChangeUserData>(_onChangeUserData);
    on<NavigateToEditProfileScreen>(_onNavigateToEditProfileScreen);
    on<NavigateToUserProfileScreen>(_onNavigateToUserProfileScreen);
    on<NavigateToPreviousScreen>(_onNavigateToPreviousScreen);

    add(const InitSettings());
  }

  Future<void> _onInitSettings(
    InitSettings event,
    Emitter<SettingsState> emit,
  ) async {
    final bool isSystemTheme = await _getCurrentThemeTypeUseCase.execute(
      const NoParams(),
    );
    final Locale locale = await _getCurrentLocaleUseCase.execute(
      const NoParams(),
    );

    emit(
      state.copyWith(locale: locale),
    );

    if (isSystemTheme) {
      emit(
        state.copyWith(isSystemTheme: isSystemTheme),
      );
    } else {
      final bool isDark = await _getCurrentThemeModeUseCase.execute(
        const NoParams(),
      );
      emit(
        state.copyWith(
          themeData: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        ),
      );
    }
  }

  Future<void> _onGetUserData(
    GetUserData event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isPageLoading: true));

    try {
      final User currentUser = await _getCurrentUserUseCase.execute(
        const NoParams(),
      );

      final bool isEmailVerified = await _checkEmailConsistencyUseCase.execute(
        const NoParams(),
      );

      emit(
        state.copyWith(
          user: currentUser,
          isEmailVerified: isEmailVerified,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(exception: () => e),
      );
    } finally {
      emit(
        state.copyWith(isPageLoading: false),
      );
    }
  }

  Future<void> _onChangeThemeType(
    ChangeThemeType event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      await _changeThemeTypeUseCase.execute(event.isSystemTheme);

      emit(
        state.copyWith(isSystemTheme: event.isSystemTheme),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(exception: () => e),
      );
    }
  }

  Future<void> _onChangeThemeMode(
    ChangeThemeMode event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      await _changeThemeModeUseCase.execute(event.isDark);

      emit(
        state.copyWith(
          isDark: event.isDark,
          themeData: event.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(exception: () => e),
      );
    }
  }

  Future<void> _onChangeLocale(
    ChangeLocale event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      await _changeLocaleUseCase.execute(event.locale);

      emit(
        state.copyWith(locale: event.locale),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(exception: () => e),
      );
    }
  }

  Future<void> _onChangeUserData(
    ChangeUserData event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final User currentUser = state.user;

      final bool isEmailVerified = event.email == currentUser.email;

      final bool hasChanges = event.firstName != currentUser.firstName ||
          event.lastName != currentUser.lastName ||
          event.email != currentUser.email ||
          event.avatar != currentUser.avatar;

      if (!hasChanges) {
        add(const NavigateToPreviousScreen());
        return;
      }

      final User updatedUser = currentUser.copyWith(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        avatar: () => event.avatar,
      );

      await _changeUserDataUseCase.execute(
        updatedUser.copyWith(avatar: () => null),
      );

      emit(
        state.copyWith(
          user: updatedUser,
          isEmailVerified: isEmailVerified,
        ),
      );

      add(const NavigateToPreviousScreen());
    } on AppException catch (e) {
      emit(
        state.copyWith(exception: () => e),
      );
    }
  }

  Future<void> _onNavigateToEditProfileScreen(
    NavigateToEditProfileScreen event,
    Emitter<SettingsState> emit,
  ) async {
    await _appRouter.push(
      EditProfileRoute(
        user: state.user,
        onSave: (User updatedUser) {
          add(
            ChangeUserData(
              firstName: updatedUser.firstName,
              lastName: updatedUser.lastName,
              email: updatedUser.email,
              avatar: updatedUser.avatar,
            ),
          );
        },
      ),
    );
  }

  Future<void> _onNavigateToUserProfileScreen(
    NavigateToUserProfileScreen event,
    Emitter<SettingsState> emit,
  ) async {
    await _appRouter.push(const UserProfileRoute());
  }

  Future<void> _onNavigateToPreviousScreen(
    NavigateToPreviousScreen event,
    Emitter<SettingsState> emit,
  ) async {
    await _appRouter.maybePop();
  }
}
