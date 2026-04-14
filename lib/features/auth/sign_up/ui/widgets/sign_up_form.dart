import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/helper/extension.dart';
import 'package:laza_ecommerce_app/core/shared/custom_text_form_field.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/logic/cubit/sign_up_cubit.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    final SignUpCubit signUpCubit = context.read<SignUpCubit>();
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //================== FirstName ================
          CustomTextField(
            // lableText: 'FirstName',
            hintText: 'First Name',
            controller: signUpCubit.firstNameController,
            validator: (val) {
              if (val.isStringNullOrEmpty()) {
                return 'name is requried';
              }
              return null;
            },
          ),

          //================== LastName ================
          CustomTextField(
            // lableText: 'Last Name',
            hintText: 'Last Name',
            controller: signUpCubit.lastNameController,
            validator: (val) {
              if (val.isStringNullOrEmpty()) {
                return 'name is requried';
              }
              return null;
            },
          ),

          //====================== email ================
          CustomTextField(
            // lableText: 'Email Address',
            hintText: 'Email',
            controller: signUpCubit.emailController,
            validator: (val) {
              if (val.isStringNullOrEmpty()) {
                return 'email is requried';
              }
              return null;
            },
          ),
          //====================== phone ================
          // CustomTextField(
          //   lableText: 'Phone',
          //   hintText: 'Phone number',
          //   controller: signUpCubit.phoneController,
          //   validator: (val) {
          //     if (val.isStringNullOrEmpty()) {
          //       return 'phone is requried';
          //     }
          //     return null;
          //   },
          // ),

          //====================== password ================
          CustomTextField(
            // lableText: 'Password',
            hintText: 'password',
            controller: signUpCubit.passwordController,
            validator: (val) {
              if (val.isStringNullOrEmpty()) {
                return 'password is requried';
              }
              return null;
            },
          ),

          //====================== confirm password ================
          CustomTextField(
            // lableText: 'Confirm Password',
            hintText: 'Confirm password',
            controller: signUpCubit.confirmPasswordController,
            validator: (val) {
              if (val.isStringNullOrEmpty()) {
                return 'confirm password is requried';
              }
              if (val != signUpCubit.passwordController.text) {
                return 'passwords do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
