import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:home_page/src/ui/widgets/feature_tile.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthController authController =
        ref.read(authControllerProvider.notifier);
    final AuthFormController formController =
        ref.read(authFormControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.auth_featureCollection.watchTr(context),
          style: AppTextTheme.font18Bold,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
      body: ListView.builder(
        itemCount: AppFeatures.values.length,
        itemBuilder: (BuildContext context, int index) {
          final AppFeatures feature = AppFeatures.values[index];
          final AppRouter appRouter = appLocator.get<AppRouter>();
          return FeatureTile(
            featureName: feature.featureName.watchTr(context),
            onTap: () => appRouter.push(feature.route),
          );
        },
      ),
    );
  }
}
