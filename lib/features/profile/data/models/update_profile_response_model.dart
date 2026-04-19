class UpdateProfileResponseModel {
  final String? message;
  final UserProfileData? user;

  UpdateProfileResponseModel({
    this.message,
    this.user,
  });

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponseModel(
      message: json['message'] as String?,
      user: json['user'] != null
          ? UserProfileData.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UserProfileData {
  final String? name;
  final String? email;
  final String? role;

  UserProfileData({
    this.name,
    this.email,
    this.role,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
      name: json['name'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
    );
  }
}
