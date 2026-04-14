import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laza_ecommerce_app/core/di/dependency_injection.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_failure_state.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_for_success_state.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/logic/cubit/reset_password_cubit.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/ui/widgets/new_password_fields.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/ui/widgets/new_password_header.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/ui/widgets/reset_password_button.dart';

class NewPasswordScreen extends StatelessWidget {
  final String email;

  const NewPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ResetPasswordCubit>(),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
              listener: (context, state) {
                if (state is ResetPasswordSuccess) {
                  setupSnackBarForSuccessState(
                    context,
                    'Password reset successfully!',
                  );
                  // Navigate to login screen
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.loginScreen,
                    (route) => false,
                  );
                } else if (state is ResetPasswordFailure) {
                  setupSnackbarForFailureState(context, state.errorMessage);
                }
              },
              builder: (context, state) {
                final cubit = context.read<ResetPasswordCubit>();

                return Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const NewPasswordHeader(),
                      SizedBox(height: 40.h),
                      const NewPasswordFields(),
                      SizedBox(height: 40.h),
                      ResetPasswordButton(email: email),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
