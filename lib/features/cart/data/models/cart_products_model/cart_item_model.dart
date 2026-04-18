class CartItemModel {
  String? itemId;
  String? productId;
  String? productName;
  String? productCoverUrl;
  int? quantity;
  int? price;

  CartItemModel({
    this.itemId,
    this.productId,
    this.productName,
    this.productCoverUrl,
    this.quantity,
    this.price,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final product = json['product'] as Map<String, dynamic>?;
    return CartItemModel(
      itemId: json['_id'] as String?,
      productId: product?['_id'] as String?,
      productName: product?['title'] as String?,
      productCoverUrl: product?['imageCover'] as String?,
      quantity: json['count'] as int?,
      price: json['price'] as int?,
    );
  }
}


