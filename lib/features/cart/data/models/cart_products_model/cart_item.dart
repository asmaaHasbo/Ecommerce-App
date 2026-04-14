class CartItemModel {
  String? itemId;
  String? productId;
  String? productName;
  String? productCoverUrl;
  int? productStock;
  double? weightInGrams;
  int? quantity;
  int? discountPercentage;
  double? basePricePerUnit; // غيّر من int? إلى double?
  double? finalPricePerUnit; // غيّر من int? إلى double?
  double? totalPrice; // غيّر من int? إلى double?

  CartItemModel({
    this.itemId,
    this.productId,
    this.productName,
    this.productCoverUrl,
    this.productStock,
    this.weightInGrams,
    this.quantity,
    this.discountPercentage,
    this.basePricePerUnit,
    this.finalPricePerUnit,
    this.totalPrice,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
    itemId: json['itemId'] as String?,
    productId: json['productId'] as String?,
    productName: json['productName'] as String?,
    productCoverUrl: json['productCoverUrl'] as String?,
    productStock: json['productStock'] as int?,
    weightInGrams: (json['weightInGrams'] as num?)?.toDouble(),
    quantity: json['quantity'] as int?,
    discountPercentage: json['discountPercentage'] as int?,
    basePricePerUnit: (json['basePricePerUnit'] as num?)?.toDouble(), // غيّر إلى toDouble
    finalPricePerUnit: (json['finalPricePerUnit'] as num?)?.toDouble(), // غيّر إلى toDouble
    totalPrice: (json['totalPrice'] as num?)?.toDouble(), // غيّر إلى toDouble
  );
}


