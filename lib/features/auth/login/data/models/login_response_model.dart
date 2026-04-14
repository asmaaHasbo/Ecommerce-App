class LoginResponseModel {
  String? accessToken;
  DateTime? expiresAtUtc;
  String? refreshToken;

  LoginResponseModel({this.accessToken, this.expiresAtUtc, this.refreshToken});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['accessToken'] as String?,
      expiresAtUtc: json['expiresAtUtc'] == null
          ? null
          : DateTime.parse(json['expiresAtUtc'] as String),
      refreshToken: json['refreshToken'] as String?,
    );
  }
}
