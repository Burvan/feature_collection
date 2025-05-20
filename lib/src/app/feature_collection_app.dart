import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:settings_page/settings_page.dart';

class FeatureCollectionApp extends StatelessWidget {
  const FeatureCollectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = appLocator<AppRouter>();

    return EasyLocalization(
      path: AppLocalization.langFolderPath,
      supportedLocales: AppLocalization.supportedLocales,
      fallbackLocale: AppLocalization.fallbackLocale,
      child: BlocProvider<SettingsBloc>(
        create: (_) => SettingsBloc(
          changeThemeTypeUseCase: appLocator.get<ChangeThemeTypeUseCase>(),
          getCurrentThemeTypeUseCase:
              appLocator.get<GetCurrentThemeTypeUseCase>(),
          changeThemeModeUseCase: appLocator.get<ChangeThemeModeUseCase>(),
          getCurrentThemeModeUseCase:
              appLocator.get<GetCurrentThemeModeUseCase>(),
          changeLocaleUseCase: appLocator.get<ChangeLocaleUseCase>(),
          getCurrentLocaleUseCase: appLocator.get<GetCurrentLocaleUseCase>(),
          getCurrentUserUseCase: appLocator.get<GetCurrentUserUseCase>(),
          changeUserDataUseCase: appLocator.get<ChangeUserDataUseCase>(),
          checkEmailConsistencyUseCase:
              appLocator.get<CheckEmailConsistencyUseCase>(),
          appRouter: appLocator.get<AppRouter>(),
        ),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (_, SettingsState state) {
            return Builder(
              builder: (BuildContext context) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  theme:
                      state.isSystemTheme ? ThemeData.light() : state.themeData,
                  darkTheme:
                      state.isSystemTheme ? ThemeData.dark() : state.themeData,
                  routerDelegate: appRouter.delegate(),
                  routeInformationParser: appRouter.defaultRouteParser(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
