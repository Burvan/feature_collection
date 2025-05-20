part of models;

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
  final Uint8List? avatar;

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
    this.avatar,
  });

  User.empty()
      : id = '',
        firstName = '',
        lastName = '',
        dateOfBirth = DateTime.now(),
        gender = Gender.other,
        customGender = null,
        phoneNumber = '',
        email = '',
        password = '',
        avatar = null;

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    Gender? gender,
    String? Function()? customGender,
    String? phoneNumber,
    String? email,
    String? password,
    Uint8List? Function()? avatar,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      customGender: customGender != null ? customGender() : this.customGender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      avatar: avatar != null ? avatar() : this.avatar,
    );
  }
}
