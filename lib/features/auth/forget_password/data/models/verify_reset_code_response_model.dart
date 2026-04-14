class VerifyResetCodeResponseModel {
  final String? status;      // For success: "Success"
  final String? statusMsg;   // For failure: "fail"
  final String? message;

  VerifyResetCodeResponseModel({
    this.status,
    this.statusMsg,
    this.message,
  });

  factory VerifyResetCodeResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyResetCodeResponseModel(
      status: json['status'] as String?,
      statusMsg: json['statusMsg'] as String?,
      message: json['message'] as String?,
    );
  }

  // Helper to check if verification was successful
  bool get isSuccess => 
      status?.toLowerCase() == 'success' || 
      statusMsg?.toLowerCase() == 'success';
}
