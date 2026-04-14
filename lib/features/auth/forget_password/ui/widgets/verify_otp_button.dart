import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/helper/extension.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';
import 'package:laza_ecommerce_app/core/shared/screens_bottom_btn.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_failure_state.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_for_success_state.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/logic/cubit/verify_otp_cubit.dart';

class VerifyOtpButton extends StatelessWidget {
  final String email;

  const VerifyOtpButton({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
      listener: (context, state) {
        if (state is VerifyOtpSuccess) {
          setupSnackBarForSuccessState(
            context,
            state.response.message ?? 'OTP verified successfully',
          );
          context.pushNamed(Routes.newPasswordScreen, arguments: email);
        } else if (state is VerifyOtpFailure) {
          setupSnackbarForFailureState(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state is VerifyOtpLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ScreensBottomBtn(
          btnName: 'Verify',
          onPressed: () => context.read<VerifyOtpCubit>().verifyOtp(),
        );
      },
    );
  }
}
