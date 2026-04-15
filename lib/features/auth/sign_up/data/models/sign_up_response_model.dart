class SignUpResponseModel {
  final String? message;
  final String? statusMsg;
  final String? token;
  final UserData? user;

  SignUpResponseModel({
    this.message,
    this.statusMsg,
    this.token,
    this.user,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignUpResponseModel(
      message: json['message'] as String?,
      statusMsg: json['statusMsg'] as String?,
      token: json['token'] as String?,
      user: json['user'] != null 
          ? UserData.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UserData {
  final String? name;
  final String? email;
  final String? role;

  UserData({
    this.name,
    this.email,
    this.role,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
    );
  }
}
