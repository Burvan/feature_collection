import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'auth_form_controller.g.dart';

@riverpod
class AuthFormController extends _$AuthFormController {
  @override
  AuthFormState build() {
    return AuthFormState.empty();
  }

  void update({
    String? firstName,
    String? lastName,
    String? email,
    DateTime? dateOfBirth,
    Gender? gender,
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