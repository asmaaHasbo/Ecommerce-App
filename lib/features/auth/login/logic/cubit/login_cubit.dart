import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/core/networking/token_storage.dart';
import 'package:laza_ecommerce_app/features/auth/login/data/models/login_resquest_model.dart';
import 'package:laza_ecommerce_app/features/auth/login/data/repositories/login_repo.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(LoginInitial());

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> emitLoginState() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(LoginLoading());

    try {
      final response = await _loginRepo.loginRepoFunction(
        LoginRequestModel(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );

      // حفظ الـ token بعد تسجيل الدخول الناجح
      if (response.token != null && response.token!.isNotEmpty) {
        await TokenStorage.saveToken(response.token!);
        log('✅ Token saved');

        // حفظ بيانات المستخدم (اختياري)
        if (response.user != null) {
          await TokenStorage.saveUserData(
            username: response.user!.name,
            email: response.user!.email,
          );
          log('✅ User data saved');
        }
      } else {
        log('⚠️ Warning: API response has no token!');
      }

      emit(LoginSuccess(response));
    } catch (e) {
      log('❌ Login Error: $e');
      emit(LoginFailure(errMsg: e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
