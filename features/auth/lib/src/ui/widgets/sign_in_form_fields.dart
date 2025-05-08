import 'package:auth/auth.dart';
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
  late final AuthFormController _formController;

  @override
  void initState() {
    super.initState();
    final AuthFormState initial = ref.read(authFormControllerProvider);
    _formController = ref.read(authFormControllerProvider.notifier);
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
    final AuthFormState formState = ref.watch(authFormControllerProvider);

    return Column(
      children: <Widget>[
        CustomTextField(
          controller: _emailController,
          labelText: LocaleKeys.auth_emailAddress.watchTr(context),
          icon: const Icon(Icons.email_outlined),
          keyBoardType: TextInputType.emailAddress,
          validator: (String? value) => Validators.emailValidator(
            value,
            context,
          ),
          onChanged: (String? value) => _formController.update(email: value),
        ),
        const SizedBox(height: 25),
        CustomTextField(
          controller: _passwordController,
          labelText: LocaleKeys.auth_password.watchTr(context),
          obscureText: formState.showPassword,
          icon: IconButton(
            onPressed: _formController.togglePasswordVisibility,
            icon: Icon(
              formState.showPassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
          ),
          validator: (String? value) => Validators.passwordValidator(
            value,
            context,
          ),
          onChanged: (String? value) => _formController.update(password: value),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
