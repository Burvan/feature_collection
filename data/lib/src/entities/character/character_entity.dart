import 'package:core/core.dart';

part 'character_entity.g.dart';

@JsonSerializable()
final class CharacterEntity {
  final int id;
  final String name;
  final String description;
  final String imagePath;
  final String? house;
  final String status;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    this.house,
    required this.status,
  });

  factory CharacterEntity.fromJson(Map<String, dynamic> json) {
    return _$CharacterEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CharacterEntityToJson(this);
}
