part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  var data;
  LoginSuccess(this.data);
}

final class LoginFailure extends LoginState {
  final String errMsg;

  LoginFailure({required this.errMsg});
}
