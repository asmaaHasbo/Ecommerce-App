class ForgetPasswordResponseModel {
  final String? statusMsg;
  final String? message;

  ForgetPasswordResponseModel({
    this.statusMsg,
    this.message,
  });

  factory ForgetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordResponseModel(
      statusMsg: json['statusMsg'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusMsg': statusMsg,
      'message': message,
    };
  }
}
