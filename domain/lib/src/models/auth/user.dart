import 'package:domain/domain.dart';

final class User {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final Gender gender;
  final String? customGender;
  final String phoneNumber;
  final String email;
  final String password;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    this.customGender,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });
}
