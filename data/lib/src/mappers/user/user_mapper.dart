part of mappers;

class UserMapper extends Mapper<UserEntity, domain.User> {
  @override
  domain.User fromEntity(UserEntity entity) {
    return domain.User(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      dateOfBirth: entity.dateOfBirth,
      gender: domain.Gender.values.firstWhere(
        (domain.Gender gender) => gender.label == entity.gender,
        orElse: () => domain.Gender.other,
      ),
      customGender: entity.gender == DataConstants.genderOther
          ? entity.customGender
          : null,
      phoneNumber: entity.phoneNumber,
      email: entity.email,
      password: entity.password,
      avatar: entity.avatar != null ? base64Decode(entity.avatar!) : null,
    );
  }

  @override
  UserEntity toEntity(domain.User item) {
    return UserEntity(
      id: item.id,
      firstName: item.firstName,
      lastName: item.lastName,
      dateOfBirth: item.dateOfBirth,
      gender: item.gender.label,
      customGender: item.gender == domain.Gender.other
          ? item.customGender
          : null,
      phoneNumber: item.phoneNumber,
      email: item.email,
      password: item.password,
      avatar: item.avatar != null ? base64Encode(item.avatar!) : null,
    );
  }
}
