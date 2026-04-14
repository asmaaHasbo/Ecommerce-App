class ResetPasswordResponseModel {
  final String? statusMsg;
  final String? message;
  final String? token;

  ResetPasswordResponseModel({
    this.statusMsg,
    this.message,
    this.token,
  });

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponseModel(
      statusMsg: json['statusMsg'] as String?,
      message: json['message'] as String?,
      token: json['token'] as String?,
    );
  }

  /// Check if the reset was successful
  /// Success: token is present
  /// Failure: statusMsg is "fail"
  bool get isSuccess => token != null && token!.isNotEmpty;
}
