part of models;

enum Gender {
  male(Icons.male, 'Male'),
  female(Icons.female, 'Female'),
  other(Icons.transgender, 'Other');

  final IconData icon;
  final String label;

  const Gender(
    this.icon,
    this.label,
  );
}
