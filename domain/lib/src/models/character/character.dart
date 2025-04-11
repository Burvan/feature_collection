final class Character {
  final int id;
  final String name;
  final String description;
  final String imagePath;
  final String? house;
  final String status;

  const Character({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.house,
    required this.status,
  });
}
