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
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final AuthFormState initial = ref.read(formNotifierProvider);
    _emailController = TextEditingController(text: initial.email);
    _passwordController = TextEditingController(text: initial.password);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
            const Text(
              AppConstants.hello,
              style: AppTextTheme.font30Bold,
            ),
            Text(
              AppConstants.pleaseLogin,
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
                    buttonText: AppConstants.signIn,
                  ),
                  if (authState is Failure)
                    Text(
                      authState.error.message ?? 'Unknown error',
                      style:
                          AppTextTheme.font16.copyWith(color: AppColors.red),
                    ),
                ],
              ),
            OfferAnotherScreen(
              question: AppConstants.noAccount,
              buttonText: AppConstants.signUp,
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
