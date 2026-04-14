import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/shared/screens_bottom_btn.dart';
import 'package:laza_ecommerce_app/features/auth/login/logic/cubit/login_cubit.dart';

class LoginBtn extends StatelessWidget {
  const LoginBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreensBottomBtn(
      btnName: 'Login',
      onPressed: () {
        final LoginCubit loginCubit = context.read<LoginCubit>();
        if (loginCubit.formKey.currentState!.validate()) {
          log('validated');
          loginCubit.emitLoginState();
        }
      },
    );
  }
}
