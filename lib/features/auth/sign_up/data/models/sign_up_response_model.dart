class SignUpResponseModel {
  String? accessToken;
  DateTime? expiresAtUtc;
  String? refreshToken;

  SignUpResponseModel({this.accessToken, this.expiresAtUtc, this.refreshToken});

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignUpResponseModel(
      accessToken: json['accessToken'] as String?,
      expiresAtUtc: json['expiresAtUtc'] == null
          ? null
          : DateTime.parse(json['expiresAtUtc'] as String),
      refreshToken: json['refreshToken'] as String?,
    );
  }
}
