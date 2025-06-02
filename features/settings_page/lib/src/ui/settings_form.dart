import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:settings_page/src/bloc/settings_bloc.dart';
import 'package:settings_page/src/ui/widgets/custom_theme_selector.dart';
import 'package:settings_page/src/ui/widgets/user_tile.dart';

class SettingsForm extends ConsumerStatefulWidget {
  const SettingsForm({super.key});

  @override
  ConsumerState<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends ConsumerState<SettingsForm> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SettingsBloc>(context).add(const GetUserData());
  }

  @override
  Widget build(BuildContext context) {
    final SettingsBloc bloc = BlocProvider.of<SettingsBloc>(context);

    final AuthController authController =
        ref.read(authControllerProvider.notifier);

    final AuthFormController formController =
        ref.read(authFormControllerProvider.notifier);

    final Size size = MediaQuery.sizeOf(context);

    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settings_userSettings.watchTr(context)),
        centerTitle: true,
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (BuildContext context, SettingsState state) {
          return state.isPageLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      UserTile(
                        id: state.user.id,
                        firstName: state.user.firstName,
                        lastName: state.user.lastName,
                        email: state.user.email,
                        avatar: state.user.avatar,
                        onAvatarTap: () {
                          bloc.add(const NavigateToUserProfileScreen());
                        },
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            bloc.add(const NavigateToEditProfileScreen());
                          },
                          child: Text(
                            LocaleKeys.settings_editUserData.watchTr(context),
                            textAlign: TextAlign.center,
                            style: AppTextTheme.font18.copyWith(
                              color: themeData.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              LocaleKeys.settings_systemTheme.watchTr(context),
                              style: AppTextTheme.font20Bold,
                            ),
                          ),
                          Switch(
                            value: state.isSystemTheme,
                            onChanged: (bool value) {
                              bloc.add(
                                ChangeThemeType(isSystemTheme: value),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (!state.isSystemTheme)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: CustomThemeSelector(
                            onLightModePressed: () {
                              bloc.add(
                                const ChangeThemeMode(isDark: false),
                              );
                            },
                            onDarkModePressed: () {
                              bloc.add(
                                const ChangeThemeMode(isDark: true),
                              );
                            },
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            LocaleKeys.settings_selectLanguage.watchTr(context),
                            style: AppTextTheme.font20Bold,
                          ),
                          SizedBox(
                            width: size.width / 3,
                            child: DropdownButtonFormField2<Locale>(
                              isExpanded: true,
                              value: state.locale,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              items: AppLocalization.supportedLocales
                                  .map((Locale locale) {
                                return DropdownMenuItem<Locale>(
                                  value: locale,
                                  child: Text(
                                    AppLocalization.getLanguageName(locale),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                              onChanged: (Locale? locale) {
                                if (locale != null && locale != state.locale) {
                                  context.setLocale(locale);
                                  bloc.add(ChangeLocale(locale: locale));
                                }
                              },
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () async {
                            await authController.signOut();
                            formController.reset();
                          },
                          child: Text(
                            LocaleKeys.settings_logOut.watchTr(context),
                            style: AppTextTheme.font18.copyWith(
                              color: themeData.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      if (state.exception != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            state.exception!.toLocalizedText(),
                            style: AppTextTheme.font16.copyWith(
                              color: AppColors.red,
                            ),
                          ),
                        ),
                      if (!state.isEmailVerified)
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            LocaleKeys.settings_emailVerificationMessage
                                .watchTr(context),
                            style: AppTextTheme.font16.copyWith(
                              color: AppColors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
