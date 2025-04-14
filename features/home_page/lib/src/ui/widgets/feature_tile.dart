import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class FeatureTile extends StatelessWidget {
  final String featureName;
  final VoidCallback onTap;

  const FeatureTile({
    required this.featureName,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.padding10),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius12),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius12),
              color: AppColors.gentlyPink,
            ),
            padding: const EdgeInsets.all(AppPadding.padding10),
            child: Text(
              featureName,
              textAlign: TextAlign.center,
              style: AppTextTheme.font18Bold.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
