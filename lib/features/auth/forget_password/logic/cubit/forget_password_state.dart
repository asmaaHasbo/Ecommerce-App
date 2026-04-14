part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoading extends ForgetPasswordState {}

final class ForgetPasswordSuccess extends ForgetPasswordState {
  final ForgetPasswordResponseModel response;

  ForgetPasswordSuccess(this.response);
}

final class ForgetPasswordFailure extends ForgetPasswordState {
  final String errorMessage;

  ForgetPasswordFailure(this.errorMessage);
}
