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
  late final AuthFormController _formController;

  @override
  void initState() {
    super.initState();
    final AuthFormState initial = ref.read(authFormControllerProvider);
    _formController = ref.read(authFormControllerProvider.notifier);
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
    final AuthFormState formState = ref.watch(authFormControllerProvider);

    return Column(
      children: <Widget>[
        CustomTextField(
          controller: _firstNameController,
          labelText: LocaleKeys.auth_firstName.watchTr(context),
          icon: const Icon(Icons.person_outline),
          validator: (String? value) => Validators.nameValidator(
            value,
            context,
          ),
          onChanged: (String? value) =>
              _formController.update(firstName: value),
        ),
        const SizedBox(height: AppSize.size25),
        CustomTextField(
          controller: _lastNameController,
          labelText: LocaleKeys.auth_lastName.watchTr(context),
          icon: const Icon(Icons.person_outline),
          validator: (String? value) => Validators.nameValidator(
            value,
            context,
          ),
          onChanged: (String? value) => _formController.update(lastName: value),
        ),
        const SizedBox(height: AppSize.size25),
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: formState.dateOfBirth ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              _formController.update(dateOfBirth: picked);
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
        CustomTextField(
          controller: _phoneNumberController,
          labelText: LocaleKeys.auth_phoneNumber.watchTr(context),
          icon: const Icon(Icons.phone_outlined),
          keyBoardType: TextInputType.phone,
          validator: (String? value) => Validators.phoneValidator(
            value,
            context,
          ),
          onChanged: (String? value) =>
              _formController.update(phoneNumber: value),
        ),
        const SizedBox(height: AppSize.size25),
        const GenderSelector(),
        const SizedBox(height: AppSize.size25),
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
        const SizedBox(height: AppSize.size25),
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
        const SizedBox(height: AppSize.size25),
        CustomTextField(
          controller: _confirmPasswordController,
          labelText:
              LocaleKeys.validationErrors_confirmPassword.watchTr(context),
          obscureText: formState.showPassword,
          icon: IconButton(
            onPressed: _formController.togglePasswordVisibility,
            icon: Icon(
              formState.showPassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
          ),
          validator: (String? value) => Validators.confirmPasswordValidator(
            value,
            formState.password,
            context,
          ),
          onChanged: (String? value) =>
              _formController.update(confirmPassword: value),
        ),
        const SizedBox(height: AppSize.size25),
      ],
    );
  }
}
