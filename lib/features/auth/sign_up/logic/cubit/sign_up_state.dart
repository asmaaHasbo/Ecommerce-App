part of 'sign_up_cubit.dart';

sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  var data;
  SignUpSuccess(this.data);
}

final class SignUpFailure extends SignUpState {
  final String errMsg;

  SignUpFailure({required this.errMsg});
}
