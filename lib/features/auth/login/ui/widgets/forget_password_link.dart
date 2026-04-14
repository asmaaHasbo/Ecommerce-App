import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/helper/extension.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';

class ForgetPasswordLink extends StatelessWidget {
  const ForgetPasswordLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            context.pushNamed(Routes.forgetPasswordScreen);
          },
          child: Text(
            'Forgot Password?',
            style: AppTextStyles.font14W500lightGray.copyWith(
              color: Colors.black,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}
