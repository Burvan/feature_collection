import 'package:flutter/material.dart';

class UserDataRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final double iconSize;

  const UserDataRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, size: iconSize),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label),
            Text(value),
          ],
        ),
      ],
    );
  }
}
