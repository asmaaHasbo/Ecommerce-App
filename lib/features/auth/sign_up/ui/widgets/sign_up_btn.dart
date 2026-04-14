import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/shared/screens_bottom_btn.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/logic/cubit/sign_up_cubit.dart';

class SignUpBtn extends StatelessWidget {
  const SignUpBtn({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return ScreensBottomBtn(
      btnName: 'Sign Up',
      onPressed: () {
        if (formKey.currentState!.validate()) {
          log('validated');
          context.read<SignUpCubit>().emitSignUpState();
        }
      },
    );
  }
}
