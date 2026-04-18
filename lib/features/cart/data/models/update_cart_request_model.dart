class UpdateCartRequestModel {
  int count;

  UpdateCartRequestModel({required this.count});

  Map<String, dynamic> toJson() => {'count': count};
}
