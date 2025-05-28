import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:user_profile/src/bloc/user_profile_bloc.dart';
import 'package:user_profile/src/ui/widgets/user_data_row.dart';

class UserProfileForm extends StatelessWidget {
  const UserProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.userProfile_profile.watchTr(context)),
        centerTitle: true,
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (BuildContext context, UserProfileState state) {
          return state.isPageLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Hero(
                          tag: state.user.id,
                          child: CircleAvatar(
                            radius: size.width / 5,
                            backgroundColor: themeData.primaryColor,
                            backgroundImage: state.user.avatar != null
                                ? MemoryImage(state.user.avatar!)
                                : null,
                            child: state.user.avatar == null
                                ? const Icon(Icons.person, size: 30)
                                : null,
                          ),
                        ),
                      ),
                      Text(
                        '${state.user.firstName} ${state.user.lastName}',
                        style: AppTextTheme.font20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: <Widget>[
                                UserDataRow(
                                  icon: Icons.cake_outlined,
                                  label: LocaleKeys.auth_dateOfBirth
                                      .watchTr(context),
                                  value: DateFormat(AppConstants.dateFormat)
                                      .format(state.user.dateOfBirth),
                                  iconSize: 24,
                                ),
                                const SizedBox(height: 10),
                                UserDataRow(
                                  icon: Icons.email_outlined,
                                  label: LocaleKeys.auth_emailAddress
                                      .watchTr(context),
                                  value: state.user.email,
                                  iconSize: 24,
                                ),
                                const SizedBox(height: 10),
                                UserDataRow(
                                  icon: state.user.gender.icon,
                                  label:
                                      LocaleKeys.auth_gender.watchTr(context),
                                  value: state.user.gender.label,
                                  iconSize: 24,
                                ),
                                const SizedBox(height: 10),
                                UserDataRow(
                                  icon: Icons.phone_outlined,
                                  label: LocaleKeys.auth_phoneNumber
                                      .watchTr(context),
                                  value: state.user.phoneNumber,
                                  iconSize: 24,
                                ),
                              ],
                            ),
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
