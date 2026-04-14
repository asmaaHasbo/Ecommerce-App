import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/shared/custom_text_form_field.dart';
import 'package:laza_ecommerce_app/core/themes/app_styles.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/logic/cubit/forget_password_cubit.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/ui/widgets/forget_password_submit_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Forget Password',
                  style: AppTextStyles.font25W600darkBlack,
                ),
                SizedBox(height: 10.h),
                Text(
                  'Enter your email address to receive a reset code',
                  style: AppTextStyles.font14W500lightGray,
                ),
                SizedBox(height: 40.h),
                CustomTextField(
                  controller: cubit.emailController,
                  hintText: 'Enter your email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.h),
                const ForgetPasswordSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
