import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class OtpHeader extends StatelessWidget {
  final String email;

  const OtpHeader({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify Code',
          style: AppTextStyles.font25W600darkBlack,
        ),
        SizedBox(height: 10.h),
        Text(
          'We sent a verification code to\n$email',
          style: AppTextStyles.font14W500lightGray,
        ),
      ],
    );
  }
}
