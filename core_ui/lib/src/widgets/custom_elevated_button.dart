import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const CustomElevatedButton({
    required this.onPressed,
    required this.buttonText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[
            AppColors.brightPink,
            AppColors.gentlyPink,
            AppColors.pinkSherbet,
            AppColors.skyBlue,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius18),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(
              horizontal: AppPadding.padding40,
              vertical: AppPadding.padding10,
            ),
          ),
          backgroundColor: const WidgetStatePropertyAll<Color>(AppColors.transparent),
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppBorderRadius.borderRadius18,
              ),
            ),
          ),
        ),
        child: Text(
          buttonText,
          style: AppTextTheme.font20Bold.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
