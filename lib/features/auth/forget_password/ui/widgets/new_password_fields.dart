import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/shared/custom_text_form_field.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/logic/cubit/reset_password_cubit.dart';

class NewPasswordFields extends StatelessWidget {
  const NewPasswordFields({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResetPasswordCubit>();

    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      buildWhen: (previous, current) =>
          current is ResetPasswordVisibilityChanged,
      builder: (context, state) {
        return Column(
          children: [
            // Password Field
            CustomTextField(
              controller: cubit.passwordController,
              hintText: 'New Password',
              isTextObsecure: cubit.obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  cubit.obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: cubit.togglePasswordVisibility,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            SizedBox(height: 14.h),

            // Confirm Password Field
            CustomTextField(
              controller: cubit.confirmPasswordController,
              hintText: 'Confirm Password',
              isTextObsecure: cubit.obscureConfirmPassword,
              suffixIcon: IconButton(
                icon: Icon(
                  cubit.obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: cubit.toggleConfirmPasswordVisibility,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != cubit.passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }
}
