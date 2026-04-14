class AddCartRequestModel {
  String? productId;
  int? quantity;

  AddCartRequestModel({this.productId, this.quantity});

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'quantity': quantity,
  };
}
