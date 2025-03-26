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
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        width: mediaQuery.size.height,
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
              height: mediaQuery.size.height * AppScale.scaleZero2,
            ),
            Text(
              AppConstants.featureCollection,
              style: AppTextTheme.font25Bold.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: AppSize.size25),
            const Expanded(
              child: SignUpForm(),
            ),
            const SizedBox(height: AppSize.size25),
          ],
        ),
      ),
    );
  }
}
