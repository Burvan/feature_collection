import 'package:auth/src/ui/widgets/auth_widgets.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Container(
        width: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              AppColors.brightPink,
              AppColors.gentlyPink,
              AppColors.pinkSherbet,
              AppColors.skyBlue,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.height / 5,
            ),
            Text(
              LocaleKeys.auth_featureCollection.watchTr(context),
              style: AppTextTheme.font25Bold.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 25),
            const Expanded(
              child: SignUpForm(),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
