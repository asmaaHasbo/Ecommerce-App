class SignUpRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String phone;

  SignUpRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': '$firstName $lastName',
      'email': email,
      'password': password,
      'rePassword': rePassword,
      'phone': phone,
    };
  }
}
