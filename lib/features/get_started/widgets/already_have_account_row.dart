import 'package:flutter/material.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class AlreadyHaveAccountRow extends StatelessWidget {
  const AlreadyHaveAccountRow({
    super.key,
    required this.questionText,
    required this.actionText,
    required this.onTap,
  });

  final String questionText;
  final String actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          questionText,
          style: AppTextStyles.font15W400lightGray,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: AppTextStyles.font15W400lightGray.copyWith(
              color: AppColors.darkBlack,
            ),
          ),
        ),
      ],
    );
  }
}
