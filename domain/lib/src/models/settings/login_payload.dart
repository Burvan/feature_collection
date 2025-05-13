part of models;

final class LoginPayload {
  final String firstName;
  final String lastName;
  final String email;

  const LoginPayload({
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}
