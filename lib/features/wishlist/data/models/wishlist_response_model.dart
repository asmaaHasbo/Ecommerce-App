import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_item_model.dart';

class WishlistResponseModel {
  final String? status;
  final String? message;
  final int? count;
  final List<ProductItemModel>? data;

  WishlistResponseModel({
    this.status,
    this.message,
    this.count,
    this.data,
  });

  factory WishlistResponseModel.fromJson(Map<String, dynamic> json) {
    return WishlistResponseModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      count: json['count'] as int?,
      data: json['data'] != null
          ? (json['data'] as List)
              .map((item) => ProductItemModel.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  /// Extract product IDs from the data
  List<String> getProductIds() {
    if (data == null) return [];
    return data!
        .where((product) => product.id != null)
        .map((product) => product.id!)
        .toList();
  }
}
