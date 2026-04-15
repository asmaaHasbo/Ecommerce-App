import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/networking/token_storage.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/data/models/sign_up_request_model.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/data/repositories/sign_up_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo _signUpRepo;
  SignUpCubit(this._signUpRepo) : super(SignUpInitial());
  
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> emitSignUpState() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(SignUpLoading());

    try {
      final response = await _signUpRepo.signUpRepoFunction(
        SignUpRequestModel(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          phone: phoneController.text.trim(),
          rePassword: confirmPasswordController.text.trim(),
        ),
      );

      // حفظ الـ token بعد التسجيل الناجح
      if (response.token != null && response.token!.isNotEmpty) {
        log('✅ SignUp Success - Saving token...');
        await TokenStorage.saveToken(response.token!);
        log('✅ Token saved');
        
        // حفظ بيانات المستخدم (اختياري)
        if (response.user != null) {
          await TokenStorage.saveUserData(
            username: response.user!.name,
            email: response.user!.email,
            phone: phoneController.text.trim(),
          );
          log('✅ User data saved');
        }
        
        // التحقق من حفظ Token
        final savedToken = await TokenStorage.getToken();
        if (savedToken != null) {
          log('✅ Token verified in storage');
        } else {
          log('❌ Token NOT found in storage after saving!');
        }
      } else {
        log('⚠️ Warning: API response has no token!');
      }

      emit(SignUpSuccess(response));
    } catch (e) {
      log('❌ SignUp Error: $e');
      emit(SignUpFailure(errMsg: e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
