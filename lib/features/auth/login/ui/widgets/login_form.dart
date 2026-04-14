import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/helper/extension.dart';
import 'package:laza_ecommerce_app/core/shared/custom_text_form_field.dart';
import 'package:laza_ecommerce_app/features/auth/login/logic/cubit/login_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginCubit loginCubit = context.read<LoginCubit>();

    return Form(
      key: loginCubit.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //====================== email ================
          CustomTextField(
            // lableText: 'Email Address',
            hintText: 'Email',
            controller: loginCubit.emailController,
            validator: (val) {
              if (val.isStringNullOrEmpty()) {
                return 'email is requried';
              }
              return null;
            },
          ),

          //====================== password ================
          CustomTextField(
            // lableText: 'Password',
            hintText: 'password',
            controller: loginCubit.passwordController,
            validator: (val) {
              if (val.isStringNullOrEmpty()) {
                return 'password is requrid';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
