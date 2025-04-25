part of mappers;

class CharacterMapper extends Mapper<CharacterEntity, domain.Character> {
  @override
  domain.Character fromEntity(CharacterEntity entity) {
    return domain.Character(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      imagePath: entity.imagePath,
      house: entity.house,
      status: domain.Status.values.firstWhere(
        (domain.Status status) => status.name == entity.status.toLowerCase(),
        orElse: () => domain.Status.unknown,
      ),
    );
  }

  @override
  CharacterEntity toEntity(domain.Character item) {
    return CharacterEntity(
      id: item.id,
      name: item.name,
      description: item.description,
      imagePath: item.imagePath,
      house: item.house,
      status: item.status.name,
    );
  }
}
