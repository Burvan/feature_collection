import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

final class Validators {
  static String? nameValidator(
    String? value,
    BuildContext context,
  ) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validationErrors_nameIsRequired.watchTr(context);
    }

    if (value.length < 2 || value.length > 20) {
      return LocaleKeys.validationErrors_nameLengthRequirements
          .watchTr(context);
    }

    return null;
  }

  static String? emailValidator(
    String? value,
    BuildContext context,
  ) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (value == null || value.isEmpty) {
      return LocaleKeys.validationErrors_emailRequired.watchTr(context);
    }

    if (!emailRegex.hasMatch(value)) {
      return LocaleKeys.validationErrors_invalidEmailFormat.watchTr(context);
    }

    return null;
  }

  static String? passwordValidator(
    String? value,
    BuildContext context,
  ) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validationErrors_passwordIsRequired.watchTr(context);
    }

    if (value.length < 8 || value.length > 16) {
      return LocaleKeys.validationErrors_passwordLengthRequirements
          .watchTr(context);
    }

    if (!value.contains(
          RegExp(r'[A-Z]'),
        ) ||
        !value.contains(
          RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
        )) {
      return LocaleKeys.validationErrors_passwordRequirements.watchTr(context);
    }

    return null;
  }

  static String? confirmPasswordValidator(
    String? value,
    String password,
    BuildContext context,
  ) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validationErrors_confirmPassword.watchTr(context);
    }

    if (value != password) {
      return LocaleKeys.validationErrors_passwordIsNotConfirmed
          .watchTr(context);
    }

    return null;
  }

  static String? phoneValidator(
    String? value,
    BuildContext context,
  ) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validationErrors_phoneNumberIsRequired.watchTr(context);
    }

    final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,12}$');
    if (!phoneRegex.hasMatch(value)) {
      return LocaleKeys.validationErrors_incorrectPhoneNumber.watchTr(context);
    }

    return null;
  }

  static String? dateOfBirthValidator(
    String? value,
    BuildContext context,
  ) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validationErrors_dateOfBirthIsRequired.watchTr(context);
    }

    return null;
  }

  static String? genderValidator(
    String? value,
    BuildContext context,
  ) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validationErrors_genderIsRequired.watchTr(context);
    }

    return null;
  }

  static String? notEmptyValidator(
      String? value,
      BuildContext context,
      ) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.validationErrors_fillInTheField.watchTr(context);
    }

    return null;
  }
}
