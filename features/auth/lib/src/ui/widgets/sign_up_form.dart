import 'package:auth/auth.dart';
import 'package:auth/src/ui/widgets/auth_widgets.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final AsyncValue<AuthState> authState = ref.watch(authControllerProvider);

    return Container(
      width: mediaQuery.size.width / AppScale.scaleOne2,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius12),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: AppSize.size10),
            Text(
              LocaleKeys.auth_pleaseSignUp.watchTr(context),
              style: AppTextTheme.font20.copyWith(color: AppColors.lightGrey),
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.padding10),
              child: Form(
                key: _formKey,
                child: const SignUpFormFields(),
              ),
            ),
            authState.when(
              loading: () => const CircularProgressIndicator(),
              error: (Object error, StackTrace stackTrace) => Column(
                children: <Widget>[
                  _buildAuthButton(),
                  const SizedBox(height: AppSize.size10),
                  Text(
                    (error as AppException).toLocalizedText(),
                    style: AppTextTheme.font16.copyWith(color: AppColors.red),
                  ),
                ],
              ),
              data: (AuthState state) => _buildAuthButton(),
            ),
            AuthSwitchPrompt(
              question: LocaleKeys.auth_alreadyHaveAccount.watchTr(context),
              buttonText: LocaleKeys.auth_signIn.watchTr(context),
              onPressed: () {
                ref.read(authControllerProvider.notifier).navigateToSignIn();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthButton() {
    return CustomElevatedButton(
      onPressed: _submit,
      buttonText: LocaleKeys.auth_signUp.watchTr(context),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ref.read(authControllerProvider.notifier).signUp();
  }
}
