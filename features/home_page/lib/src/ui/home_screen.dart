import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthNotifier authNotifier = ref.read(authNotifierProvider.notifier);
    final FormNotifier formNotifier = ref.read(formNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.auth_featureCollection.watchTr(context),
          style: AppTextTheme.font16WhiteBold,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.brightPink,
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await authNotifier.signOut();
              formNotifier.reset();
              context.navigateTo(const SignInRoute());
            },
            icon: const Icon(
              Icons.logout,
              color: AppColors.white,
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text('Home screen'),
      ),
    );
  }
}
