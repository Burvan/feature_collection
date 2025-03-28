import 'package:auth/auth.dart';
import 'package:auth/src/ui/widgets/auth_widgets.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class SignInFormFields extends ConsumerStatefulWidget {
  const SignInFormFields({super.key});

  @override
  ConsumerState<SignInFormFields> createState() => _SignInFormFieldsState();
}

class _SignInFormFieldsState extends ConsumerState<SignInFormFields> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

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
    final AuthFormState authFormState = ref.watch(formNotifierProvider);
    final FormNotifier formNotifier = ref.watch(formNotifierProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_emailController.text != authFormState.email) {
        _emailController.text = authFormState.email;
      }
      if (_passwordController.text != authFormState.password) {
        _passwordController.text = authFormState.password;
      }
    });

    return Column(
      children: <Widget>[
        AuthTextField(
          controller: _emailController,
          labelText: LocaleKeys.auth_emailAddress.watchTr(context),
          obscureText: false,
          icon: const Icon(Icons.email_outlined),
          keyBoardType: TextInputType.emailAddress,
          validator: (String? value) => Validators.emailValidator(
            value,
            context,
          ),
          onChanged: (String? value) => formNotifier.update(email: value),
        ),
        const SizedBox(height: AppSize.size25),
        AuthTextField(
          controller: _passwordController,
          labelText: LocaleKeys.auth_password.watchTr(context),
          obscureText: !authFormState.showPassword,
          icon: IconButton(
            onPressed: formNotifier.togglePasswordVisibility,
            icon: Icon(
              authFormState.showPassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
          ),
          validator: (String? value) => Validators.passwordValidator(
            value,
            context,
          ),
          onChanged: (String? value) => formNotifier.update(password: value),
        ),
        const SizedBox(height: AppSize.size25),
      ],
    );
  }
}
