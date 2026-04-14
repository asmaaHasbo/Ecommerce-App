import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class OtpScreen extends StatelessWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
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
              SizedBox(height: 40.h),
              // TODO: Add OTP input fields here
              Center(
                child: Text(
                  'OTP Screen - Coming Soon',
                  style: AppTextStyles.font14W500lightGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
