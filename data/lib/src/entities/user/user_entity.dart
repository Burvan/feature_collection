import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String gender;
  final String phoneNumber;
  final String email;
  final String password;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return _$UserEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}