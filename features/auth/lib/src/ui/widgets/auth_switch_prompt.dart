import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class AuthSwitchPrompt extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final String question;

  const AuthSwitchPrompt({
    required this.onPressed,
    required this.buttonText,
    required this.question,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          question,
          style: AppTextTheme.font16.copyWith(
            color: AppColors.lightGrey,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: AppTextTheme.font16.copyWith(
              color: AppColors.gentlyPink,
            ),
          ),
        ),
      ],
    );
  }
}