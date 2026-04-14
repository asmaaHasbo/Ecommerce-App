import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/helper/extension.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';
import 'package:laza_ecommerce_app/core/shared/screens_bottom_btn.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_failure_state.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_for_success_state.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/logic/cubit/forget_password_cubit.dart';

class ForgetPasswordSubmitButton extends StatelessWidget {
  const ForgetPasswordSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Get cubit instance from context
    final cubit = context.read<ForgetPasswordCubit>();

    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      // Listener: يتنفذ لما الـ state يتغير (للـ side effects)
      listener: (context, state) {
        // Success case: عرض رسالة نجاح + الانتقال لشاشة OTP
        if (state is ForgetPasswordSuccess) {
          setupSnackBarForSuccessState(
            context,
            state.response.message ?? 'Reset code sent successfully',
          );
          
          // Navigate to OTP screen with email as argument
          context.pushNamed(
            Routes.otpScreen,
            arguments: cubit.emailController.text.trim(),
          );
        } 
        // Failure case: عرض رسالة الخطأ
        else if (state is ForgetPasswordFailure) {
          setupSnackbarForFailureState(context, state.errorMessage);
        }
      },
      
      // Builder: يبني الـ UI بناءً على الـ state
      builder: (context, state) {
        // Loading state: عرض loading indicator
        if (state is ForgetPasswordLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        
        // Default state: عرض الزر
        return ScreensBottomBtn(
          btnName: 'Send Reset Code',
          onPressed: () => cubit.sendResetCode(),
        );
      },
    );
  }
}
