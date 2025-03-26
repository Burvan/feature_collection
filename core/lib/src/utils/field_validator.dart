import 'package:core/core.dart';

class FieldValidator {
  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.nameIsRequired;
    }

    if (value.length < 2 || value.length > 20) {
      return AppConstants.nameLengthRequirements;
    }

    return null;
  }

  static String? emailValidator(String? value) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (value == null || value.isEmpty) {
      return AppConstants.emailIsRequired;
    }

    if (!emailRegex.hasMatch(value)) {
      return AppConstants.enterValidEmail;
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.passwordIsRequired;
    }

    if (value.length < 8 || value.length > 16) {
      return AppConstants.passwordLengthRequirements;
    }

    if (!value.contains(
          RegExp(r'[A-Z]'),
        ) ||
        !value.contains(
          RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
        )) {
      return AppConstants.passwordRequirements;
    }

    return null;
  }

  static String? confirmPasswordValidator(String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppConstants.confirmPassword;
    }

    if (value != password) {
      return AppConstants.passwordIsNotConfirmed;
    }

    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.phoneNumberIsRequired;
    }

    final phoneRegex = RegExp(r'^\+?[0-9]{10,12}$');
    if (!phoneRegex.hasMatch(value)) {
      return AppConstants.incorrectPhoneNumber;
    }

    return null;
  }

  static String? dateOfBirthValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.dateOfBirthIsRequired;
    }

    return null;
  }

  static String? genderValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.genderIsRequired;
    }

    return null;
  }
}
