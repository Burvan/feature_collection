import 'package:auth/auth.dart';
import 'package:core/core.dart';

class FormNotifier extends StateNotifier<AuthFormState> {
  FormNotifier() : super(AuthFormState.empty());

  void update({
    String? firstName,
    String? lastName,
    String? email,
    DateTime? dateOfBirth,
    String? gender,
    String? customGender,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
    bool? showCustomGenderField,
  }) {
    state = state.copyWith(
      firstName: firstName ?? state.firstName,
      lastName: lastName ?? state.lastName,
      email: email ?? state.email,
      dateOfBirth: dateOfBirth ?? state.dateOfBirth,
      gender: gender ?? state.gender,
      customGender: customGender ?? state.customGender,
      phoneNumber: phoneNumber ?? state.phoneNumber,
      password: password ?? state.password,
      confirmPassword: confirmPassword ?? state.confirmPassword,
      showCustomGenderField: showCustomGenderField ?? state.showCustomGenderField,
    );
  }

  void togglePasswordVisibility() {
    state = state.copyWith(showPassword: !state.showPassword);
  }

  void reset() {
    state = AuthFormState.empty();
  }
}
