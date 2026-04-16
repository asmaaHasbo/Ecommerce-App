import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/helper/extension.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';
import 'package:laza_ecommerce_app/features/auth/login/ui/widgets/forget_password_link.dart';
import 'package:laza_ecommerce_app/features/auth/login/ui/widgets/login_bloc_listener.dart';
import 'package:laza_ecommerce_app/features/auth/login/ui/widgets/login_btn.dart';
import 'package:laza_ecommerce_app/features/auth/login/ui/widgets/login_form.dart';
import 'package:laza_ecommerce_app/features/auth/login/ui/widgets/welcome_text.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/ui/widgets/rememper_me_row.dart';
import 'package:laza_ecommerce_app/features/get_started/widgets/already_have_account_row.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              WelcomeText(),

              SizedBox(height: 100.h),

              LoginForm(),

              RememperMeRow(),

              ForgetPasswordLink(),

              SizedBox(height: 30.h),

              AlreadyHaveAccountRow(
                questionText: "Don't have an account ?",
                actionText: 'Sign Up',
                onTap: () {
                  context.pushNamed(Routes.signUpScreen);
                },
              ),

              SizedBox(height: 30.h),

              LoginBtn(),

              LoginBlocListener(),
            ],
          ),
        ),
      ),
    );
  }
}
