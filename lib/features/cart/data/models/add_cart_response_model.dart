class AddCartResponseModel {
  String? message;
  String? id;
  String? productId;
  int? quantity;

  AddCartResponseModel({this.message, this.id, this.productId, this.quantity});

  factory AddCartResponseModel.fromJson(Map<String, dynamic> json) {
    return AddCartResponseModel(
      message: json['message'] as String?,
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      quantity: json['quantity'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'id': id,
    'productId': productId,
    'quantity': quantity,
  };
}
