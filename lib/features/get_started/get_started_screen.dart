import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/helper/extension.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';
import 'package:laza_ecommerce_app/core/shared/screens_bottom_btn.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/get_started/widgets/already_have_account_row.dart';
import 'package:laza_ecommerce_app/features/get_started/widgets/social_media_btns.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Let’s Get Started',
              style: AppTextStyles.font25W600darkBlack.copyWith(
                fontSize: 28.sp,
              ),
            ),

            Spacer(),

            SocialMediaBtns(),

            Spacer(),

            AlreadyHaveAccountRow(
              questionText: 'Already have an account? ',
              actionText: 'Login',
              onTap: () {
                context.pushNamed(Routes.loginScreen);
              },
            ),

            SizedBox(height: 10.h),

            ScreensBottomBtn(
              btnName: 'Create an Account',
              onPressed: () {
                context.pushNamed(Routes.signUpScreen);
              },
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
