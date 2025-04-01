import 'package:auth/auth.dart';
import 'package:auth/src/ui/widgets/auth_widgets.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({super.key});

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final AsyncValue<AuthState> authState = ref.watch(authControllerProvider);
    final AuthFormState formState = ref.watch(authFormControllerProvider);

    return Container(
      width: mediaQuery.size.width / AppScale.scaleOne2,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.padding10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              LocaleKeys.auth_hello.watchTr(context),
              style: AppTextTheme.font30Bold,
            ),
            Text(
              LocaleKeys.auth_pleaseLogin.watchTr(context),
              style: AppTextTheme.font20.copyWith(color: AppColors.lightGrey),
            ),
            Form(
              key: _formKey,
              child: const SignInFormFields(),
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
              question: LocaleKeys.auth_noAccount.watchTr(context),
              buttonText: LocaleKeys.auth_signUp.watchTr(context),
              onPressed: () {
                ref.read(authControllerProvider.notifier).navigateToSignUp();
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
      buttonText: LocaleKeys.auth_signIn.watchTr(context),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final AuthFormState formState = ref.read(authFormControllerProvider);
    ref.read(authControllerProvider.notifier).signIn(
      formState.email,
      formState.password,
    );
  }
}
