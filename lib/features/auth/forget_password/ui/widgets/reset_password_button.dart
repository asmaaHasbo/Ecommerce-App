import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/shared/screens_bottom_btn.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/logic/cubit/reset_password_cubit.dart';

class ResetPasswordButton extends StatelessWidget {
  final String email;

  const ResetPasswordButton({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return ScreensBottomBtn(
      btnName: 'Reset Password',
      onPressed: () => context.read<ResetPasswordCubit>().resetPassword(email),
    );
  }
}
