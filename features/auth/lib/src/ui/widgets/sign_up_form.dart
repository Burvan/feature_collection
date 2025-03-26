import 'package:auth/auth.dart';
import 'package:auth/src/ui/widgets/auth_widgets.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:home_page/home_page.dart';
import 'package:navigation/navigation.dart';

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
    final AuthState authState = ref.watch(authNotifierProvider);

    ref.listen<AuthState>(authNotifierProvider, (_, AuthState state) {
      if (state is Success) {
        context.navigateTo(const HomeRoute());
      }
    });

    if (authState is Loading) {
      return const Center(child: CircularProgressIndicator());
    }

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
              AppConstants.pleaseSignUp,
              style: AppTextTheme.font20.copyWith(color: AppColors.lightGrey),
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.padding10),
              child: Form(
                key: _formKey,
                child: const SignUpFormFields(),
              ),
            ),
            if (authState is Loading)
              const CircularProgressIndicator()
            else
              Column(
                children: <Widget>[
                  CustomElevatedButton(
                    onPressed: () => _submit(ref),
                    buttonText: AppConstants.signUp,
                  ),
                  if (authState is Failure)
                    Padding(
                      padding: const EdgeInsets.only(top: AppPadding.padding10),
                      child: Text(
                        authState.message,
                        style:
                            AppTextTheme.font16.copyWith(color: AppColors.red),
                      ),
                    ),
                ],
              ),
            OfferAnotherScreen(
              question: AppConstants.alreadyHaveAccount,
              buttonText: AppConstants.signIn,
              onPressed: () {
                context.navigateTo(const SignInRoute());
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

    ref.read(authNotifierProvider.notifier).signUp(
          firstName: formState.firstName,
          lastName: formState.lastName,
          dateOfBirth: formState.dateOfBirth!,
          gender: formState.gender!,
          phoneNumber: formState.phoneNumber,
          email: formState.email,
          password: formState.password,
        );
  }
}
