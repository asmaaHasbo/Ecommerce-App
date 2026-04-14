import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/logic/cubit/verify_otp_cubit.dart';

class OtpTimerSection extends StatelessWidget {
  final String email;

  const OtpTimerSection({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VerifyOtpCubit>();

    return BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
      builder: (context, state) {
        return Column(
          children: [
            // Timer Display
            if (state is VerifyOtpTimerUpdate || state is VerifyOtpInitial)
              Center(
                child: Text(
                  'Code expires in: ${cubit.getFormattedTime()}',
                  style: AppTextStyles.font14W500lightGray,
                ),
              ),

            // Expired Message
            if (state is VerifyOtpExpired)
              Center(
                child: Text(
                  'Code has expired',
                  style: AppTextStyles.font14W500lightGray.copyWith(
                    color: Colors.red,
                  ),
                ),
              ),

            SizedBox(height: 20.h),

            // Resend Button
            Center(
              child: TextButton(
                onPressed: cubit.canResend() ? () => cubit.resendCode(email) : null,
                child: Text(
                  'Resend Code',
                  style: AppTextStyles.font14W500lightGray.copyWith(
                    color: cubit.canResend()
                        ? AppColors.primaryColor
                        : AppColors.lightGray,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
