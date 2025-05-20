import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class VerificationRequiredScreen extends ConsumerWidget {
  const VerificationRequiredScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AuthState> authState = ref.watch(authControllerProvider);

    Widget buildAuthButton() {
      return CustomElevatedButton(
        onPressed: () {
          ref.read(authControllerProvider.notifier).checkVerification();
        },
        buttonText: LocaleKeys.auth_signIn.watchTr(context),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.auth_emailVerification.watchTr(context)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                LocaleKeys.auth_pleaseVerifyEmail.watchTr(context),
                textAlign: TextAlign.center,
                style: AppTextTheme.font20Bold,
              ),
              const SizedBox(height: 10),
              authState.when(
                loading: () => const CircularProgressIndicator(),
                error: (Object error, StackTrace stackTrace) => Column(
                  children: <Widget>[
                    buildAuthButton(),
                    const SizedBox(height: 10),
                    Text(
                      (error as AppException).toLocalizedText(),
                      style: AppTextTheme.font16.copyWith(color: AppColors.red),
                    ),
                  ],
                ),
                data: (AuthState state) => buildAuthButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
