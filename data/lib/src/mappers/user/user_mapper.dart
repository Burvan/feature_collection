part of mappers;

class UserMapper extends Mapper<UserEntity, domain.User> {
  @override
  domain.User fromEntity(UserEntity entity) {
    return domain.User(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      dateOfBirth: entity.dateOfBirth,
      gender: entity.gender,
      phoneNumber: entity.phoneNumber,
      email: entity.email,
      password: entity.password,
    );
  }

  @override
  UserEntity toEntity(domain.User item) {
    return UserEntity(
      id: item.id,
      firstName: item.firstName,
      lastName: item.lastName,
      dateOfBirth: item.dateOfBirth,
      gender: item.gender,
      phoneNumber: item.phoneNumber,
      email: item.email,
      password: item.password,
    );
  }
}
