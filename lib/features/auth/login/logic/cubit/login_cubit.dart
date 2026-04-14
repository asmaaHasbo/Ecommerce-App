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

      // حفظ الـ tokens بعد تسجيل الدخول الناجح
      if (response.accessToken != null && response.accessToken!.isNotEmpty) {
        await TokenStorage.saveToken(response.accessToken!);
        if (response.refreshToken != null &&
            response.refreshToken!.isNotEmpty) {
          await TokenStorage.saveRefreshToken(response.refreshToken!);
        }
      }

      emit(LoginSuccess(response));
    } catch (e) {
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
