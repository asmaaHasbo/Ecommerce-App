class UpdateProfileRequestModel {
  final String? name;
  final String? email;
  final String? phone;

  UpdateProfileRequestModel({
    this.name,
    this.email,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    return data;
  }
}
