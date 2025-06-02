import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class CustomThemeSelector extends StatelessWidget {
  final VoidCallback onLightModePressed;
  final VoidCallback onDarkModePressed;

  const CustomThemeSelector({
    required this.onLightModePressed,
    required this.onDarkModePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            LocaleKeys.settings_customTheme.watchTr(context),
            style: AppTextTheme.font20Bold,
          ),
        ),
        Row(
          children: <Widget>[
            IconButton(
              onPressed: onLightModePressed,
              icon: const Icon(
                Icons.light_mode,
                color: AppColors.brightPink,
              ),
            ),
            IconButton(
              onPressed: onDarkModePressed,
              icon: const Icon(
                Icons.dark_mode,
                color: AppColors.yellow,
              ),
            )
          ],
        ),
      ],
    );
  }
}
