part of models;

final class Character {
  final int id;
  final String name;
  final String description;
  final String imagePath;
  final String? house;
  final Status status;

  const Character({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.status,
    this.house,
  });
}
