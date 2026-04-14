import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/helper/extension.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/ui/widgets/rememper_me_row.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/ui/widgets/sign_up_bloc_builder.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/ui/widgets/sign_up_btn.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/ui/widgets/sign_up_form.dart';
import 'package:laza_ecommerce_app/features/get_started/widgets/already_have_account_row.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sign Up',
                style: AppTextStyles.font25W600darkBlack.copyWith(
                  fontSize: 28.sp,
                ),
              ),

              SizedBox(height: 30.h),

              SignUpForm(),

              RememperMeRow(),

              SizedBox(height: 20.h),

              AlreadyHaveAccountRow(
                questionText: 'Already have an account? ',
                actionText: 'Signin',
                onTap: () {
                  context.pushNamed(Routes.loginScreen);
                },
              ),

              SizedBox(height: 30.h),

              SignUpBtn(),

              SizedBox(height: 20.h),

              SignUpBlocListener(),
            ],
          ),
        ),
      ),
    );
  }
}
