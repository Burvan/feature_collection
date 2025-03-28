import 'package:auth/auth.dart';
import 'package:auth/src/ui/widgets/auth_widgets.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class SignUpFormFields extends ConsumerStatefulWidget {
  const SignUpFormFields({super.key});

  @override
  ConsumerState<SignUpFormFields> createState() => _SignUpFormFieldsState();
}

class _SignUpFormFieldsState extends ConsumerState<SignUpFormFields> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _dateOfBirthController;

  @override
  void initState() {
    super.initState();
    final AuthFormState initial = ref.read(formNotifierProvider);
    _firstNameController = TextEditingController(text: initial.firstName);
    _lastNameController = TextEditingController(text: initial.lastName);
    _emailController = TextEditingController(text: initial.email);
    _passwordController = TextEditingController(text: initial.password);
    _confirmPasswordController =
        TextEditingController(text: initial.confirmPassword);
    _phoneNumberController = TextEditingController(text: initial.phoneNumber);
    _dateOfBirthController = TextEditingController(
      text: initial.dateOfBirth?.toLocal().toString().split(' ')[0] ?? '',
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthFormState authFormState = ref.watch(formNotifierProvider);
    final FormNotifier formNotifier = ref.watch(formNotifierProvider.notifier);

    return Column(
      children: <Widget>[
        AuthTextField(
          controller: _firstNameController,
          labelText: LocaleKeys.auth_firstName.watchTr(context),
          obscureText: false,
          icon: const Icon(Icons.person_outline),
          validator: (String? value) => Validators.nameValidator(
            value,
            context,
          ),
          onChanged: (String? value) => formNotifier.update(firstName: value),
        ),
        const SizedBox(height: AppSize.size25),
        AuthTextField(
          controller: _lastNameController,
          labelText: LocaleKeys.auth_lastName.watchTr(context),
          obscureText: false,
          icon: const Icon(Icons.person_outline),
          validator: (String? value) => Validators.nameValidator(
            value,
            context,
          ),
          onChanged: (String? value) => formNotifier.update(lastName: value),
        ),
        const SizedBox(height: AppSize.size25),
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: authFormState.dateOfBirth ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              formNotifier.update(dateOfBirth: picked);
              _dateOfBirthController.text =
                  picked.toLocal().toString().split(' ')[0];
            }
          },
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: LocaleKeys.auth_dateOfBirth.watchTr(context),
              suffixIcon: const Icon(Icons.calendar_today),
            ),
            child: Text(_dateOfBirthController.text),
          ),
        ),
        AuthTextField(
          controller: _phoneNumberController,
          labelText: LocaleKeys.auth_phoneNumber.watchTr(context),
          obscureText: false,
          icon: const Icon(Icons.phone_outlined),
          keyBoardType: TextInputType.phone,
          validator: (String? value) => Validators.phoneValidator(
            value,
            context,
          ),
          onChanged: (String? value) => formNotifier.update(phoneNumber: value),
        ),
        const SizedBox(height: AppSize.size25),
        const GenderSelector(),
        const SizedBox(height: AppSize.size25),
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
        AuthTextField(
          controller: _confirmPasswordController,
          labelText:
              LocaleKeys.validationErrors_confirmPassword.watchTr(context),
          obscureText: !authFormState.showPassword,
          icon: IconButton(
            onPressed: formNotifier.togglePasswordVisibility,
            icon: Icon(
              authFormState.showPassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
          ),
          validator: (String? value) => Validators.confirmPasswordValidator(
            value,
            authFormState.password,
            context,
          ),
          onChanged: (String? value) =>
              formNotifier.update(confirmPassword: value),
        ),
        const SizedBox(height: AppSize.size25),
      ],
    );
  }
}
