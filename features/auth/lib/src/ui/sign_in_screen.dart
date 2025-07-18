import 'package:auth/src/ui/widgets/auth_widgets.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                AppColors.indigo,
                AppColors.turquoise,
                AppColors.skyBlue,
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: size.height / 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  LocaleKeys.auth_featureCollection.watchTr(context),
                  style: AppTextTheme.font25Bold.copyWith(
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              const SignInForm(),
            ],
          ),
        ),
      ),
    );
  }
}
