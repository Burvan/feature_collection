import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final String? helperText;
  final String? hintText;
  final TextInputType? keyBoardType;
  final String labelText;
  final bool obscureText;
  final Widget? icon;
  final bool enabled;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final TextInputAction? textInputAction;

  const CustomTextField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.helperText,
    this.hintText,
    this.keyBoardType,
    required this.labelText,
    this.obscureText = false,
    this.icon,
    this.enabled = true,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      obscureText: obscureText,
      keyboardType: keyBoardType,
      enabled: enabled,
      autofocus: autofocus,
      maxLines: maxLines,
      minLines: minLines,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        suffixIcon: icon,
        labelText: labelText,
        helperText: helperText,
        hintText: hintText,
      ),
    );
  }
}