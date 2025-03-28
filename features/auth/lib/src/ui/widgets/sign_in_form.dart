import 'package:auth/auth.dart';
import 'package:auth/src/ui/widgets/auth_widgets.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:home_page/home_page.dart';
import 'package:navigation/navigation.dart';

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
    final AuthState authState = ref.watch(authNotifierProvider);

    ref.listen<AuthState>(authNotifierProvider, (_, AuthState state) {
      if (state is Success) {
        context.navigateTo(const HomeRoute());
      }
    });

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
            if (authState is Loading)
              const CircularProgressIndicator()
            else
              Column(
                children: <Widget>[
                  CustomElevatedButton(
                    onPressed: () => _submit(ref),
                    buttonText: LocaleKeys.auth_signIn.watchTr(context),
                  ),
                  if (authState is Failure)
                    Text(
                      authState.error.message ?? 'Unknown error',
                      style: AppTextTheme.font16.copyWith(color: AppColors.red),
                    ),
                ],
              ),
            AuthSwitchPrompt(
              question: LocaleKeys.auth_noAccount.watchTr(context),
              buttonText: LocaleKeys.auth_signUp.watchTr(context),
              onPressed: () {
                context.navigateTo(const SignUpRoute());
              },
            ),
          ],
        ),
      ),
    );
  }

  void _submit(WidgetRef ref) {
    if (!_formKey.currentState!.validate()) return;

    final AuthFormState formState = ref.read(formNotifierProvider);

    ref.read(authNotifierProvider.notifier).signIn(
          formState.email,
          formState.password,
        );
  }
}
