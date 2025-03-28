import 'package:flutter/material.dart';

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
