import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/models/reset_password_response_model.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/repositories/reset_password_repo.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordRepo _repo;

  ResetPasswordCubit(this._repo) : super(ResetPasswordInitial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    emit(ResetPasswordVisibilityChanged());
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    emit(ResetPasswordVisibilityChanged());
  }

  Future<void> resetPassword(String email) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(ResetPasswordLoading());

    try {
      final response = await _repo.resetPassword(
        email: email,
        newPassword: passwordController.text.trim(),
      );

      if (response.isSuccess) {
        emit(ResetPasswordSuccess(response));
      } else {
        emit(ResetPasswordFailure(
          response.message ?? 'Reset code not verified',
        ));
      }
    } catch (e) {
      emit(ResetPasswordFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
