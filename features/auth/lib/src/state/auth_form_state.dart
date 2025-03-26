import 'package:core/core.dart';

part 'auth_form_state.freezed.dart';

@freezed
abstract class AuthFormState with _$AuthFormState {
  const factory AuthFormState({
    required String firstName,
    required String lastName,
    required String email,
    required DateTime? dateOfBirth,
    required String? gender,
    required String? customGender,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    @Default(false) bool showPassword,
    @Default(false) bool showCustomGenderField,
  }) = _AuthFormState;

  factory AuthFormState.empty() => const AuthFormState(
    firstName: '',
    lastName: '',
    email: '',
    dateOfBirth: null,
    gender: null,
    customGender: null,
    phoneNumber: '',
    password: '',
    confirmPassword: '',
  );
}