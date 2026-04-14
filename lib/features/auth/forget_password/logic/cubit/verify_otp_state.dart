part of 'verify_otp_cubit.dart';

@immutable
sealed class VerifyOtpState {}

final class VerifyOtpInitial extends VerifyOtpState {}

final class VerifyOtpLoading extends VerifyOtpState {}

final class VerifyOtpSuccess extends VerifyOtpState {
  final VerifyResetCodeResponseModel response;
  VerifyOtpSuccess(this.response);
}

final class VerifyOtpFailure extends VerifyOtpState {
  final String errorMessage;
  VerifyOtpFailure(this.errorMessage);
}

final class VerifyOtpTimerUpdate extends VerifyOtpState {
  final int remainingSeconds;
  VerifyOtpTimerUpdate(this.remainingSeconds);
}

final class VerifyOtpExpired extends VerifyOtpState {}

final class VerifyOtpResent extends VerifyOtpState {}
