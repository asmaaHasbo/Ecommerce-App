import 'package:flutter/material.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class TermAndCondition extends StatelessWidget {
  const TermAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Confirm that you agree with our',
          style: AppTextStyles.font15W400lightGray,
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Term and Condition',
            style: AppTextStyles.font15W400lightGray.copyWith(
              color: AppColors.darkBlack,
            ),
          ),
        ),
      ],
    );
  }
}
