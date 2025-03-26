import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? helperText;
  final TextInputType? keyBoardType;
  final String labelText;
  final bool obscureText;
  final Widget icon;

  const AuthTextField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.helperText,
    this.keyBoardType,
    required this.labelText,
    required this.obscureText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        suffixIcon: icon,
        labelText: labelText,
        helperText: helperText,
      ),
    );
  }
}
