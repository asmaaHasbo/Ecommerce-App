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

      // حفظ الـ tokens بعد التسجيل الناجح
      if (response.accessToken != null && response.accessToken!.isNotEmpty) {
        await TokenStorage.saveToken(response.accessToken!);
        if (response.refreshToken != null && response.refreshToken!.isNotEmpty) {
          await TokenStorage.saveRefreshToken(response.refreshToken!);
        }
      }

      emit(SignUpSuccess(response));
    } catch (e) {
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
