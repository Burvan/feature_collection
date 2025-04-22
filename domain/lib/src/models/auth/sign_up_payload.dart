part of models;

final class SignUpPayload {
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final Gender gender;
  final String phoneNumber;
  final String email;
  final String password;

  const SignUpPayload({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });
}
