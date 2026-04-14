import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class NewPasswordHeader extends StatelessWidget {
  const NewPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'New Password',
          style: AppTextStyles.font25W600darkBlack,
        ),
        SizedBox(height: 10.h),
        Text(
          'Enter your new password',
          style: AppTextStyles.font14W500lightGray,
        ),
      ],
    );
  }
}
