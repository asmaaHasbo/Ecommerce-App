import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/helper/extension.dart';
import 'package:laza_ecommerce_app/core/routing/routes.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_failure_state.dart';
import 'package:laza_ecommerce_app/core/shared/setup_snack_bar_for_success_state.dart';
import 'package:laza_ecommerce_app/core/themes/app_colors.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/logic/cubit/sign_up_cubit.dart';

class SignUpBlocListener extends StatelessWidget {
  const SignUpBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        //=================== loading ==============
        if (state is SignUpLoading) {
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
        if (state is SignUpSuccess) {
          context.pop(); // Close the loading dialog
          setupSnackBarForSuccessState(
            context,
            'Account created successfully!',
          );
          context.pushReplacementNamed(Routes.mainScreen);
        }

        //=================== failure ===============
        if (state is SignUpFailure) {
          context.pop(); // Close the loading dialog
          FocusScope.of(context).unfocus();
          setupSnackbarForFailureState(context, state.errMsg);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
