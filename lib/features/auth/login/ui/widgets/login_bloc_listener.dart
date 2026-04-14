import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/helper/extension.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_failure_state.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_for_success_state.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/features/auth/login/logic/cubit/login_cubit.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        //=================== loading ==============
        if (state is LoginLoading) {
          // Hide keyboard when loading starts
          FocusScope.of(context).unfocus();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(color: AppColors.ligtBlue),
            ),
          );
        }

        //==================== success ============
        if (state is LoginSuccess) {
          context.pop(); // Close the loading dialog
          setupSnackBarForSuccessState(
            context,
            'Login successful!',
          );
          context.pushReplacementNamed(Routes.mainScreen);
        }

        //=================== failure ===============
        if (state is LoginFailure) {
          context.pop(); // Close the loading dialog
          FocusScope.of(context).unfocus();
          setupSnackbarForFailureState(context, state.errMsg);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
