import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/ui/widgets/otp_header.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/ui/widgets/otp_input_fields.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/ui/widgets/otp_timer_section.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/ui/widgets/verify_otp_button.dart';

class OtpScreen extends StatelessWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OtpHeader(email: email),
              SizedBox(height: 40.h),
              const OtpInputFields(),
              SizedBox(height: 30.h),
              OtpTimerSection(email: email),
              SizedBox(height: 40.h),
              const VerifyOtpButton(),
            ],
          ),
        ),
      ),
    );
  }
}
