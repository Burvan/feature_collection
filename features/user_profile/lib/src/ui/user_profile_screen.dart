import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:user_profile/src/bloc/user_profile_bloc.dart';
import 'package:user_profile/src/ui/user_profile_form.dart';

@RoutePage()
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserProfileBloc>(
      create: (_) => UserProfileBloc(
        getCurrentUserUseCase: appLocator.get<FetchCurrentUserUseCase>(),
      ),
      child: const UserProfileForm(),
    );
  }
}
