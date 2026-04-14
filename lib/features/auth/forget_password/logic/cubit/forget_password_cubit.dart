import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/models/forget_password_response_model.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/repositories/forget_password_repo.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordRepo _repo;

  ForgetPasswordCubit(this._repo) : super(ForgetPasswordInitial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  Future<void> sendResetCode() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(ForgetPasswordLoading());

    try {
      final response = await _repo.sendResetCode(emailController.text.trim());
      emit(ForgetPasswordSuccess(response));
    } catch (e) {
      emit(ForgetPasswordFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
