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
    final AuthController authController = ref.read(authControllerProvider.notifier);
    final AuthFormController formController = ref.read(authFormControllerProvider.notifier);

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
              await authController.signOut();
              formController.reset();
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
