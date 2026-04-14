import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_item_model.dart';

class ProductsModel {
  List<ProductItemModel>? items;
  int? page;
  int? pageSize;
  int? totalCount;
  bool? hasNextPage;
  bool? hasPreviousPage;

  ProductsModel({
    this.items,
    this.page,
    this.pageSize,
    this.totalCount,
    this.hasNextPage,
    this.hasPreviousPage,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => ProductItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      page: json['page'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 10,
      totalCount: json['totalCount'] as int? ?? 0,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
      hasPreviousPage: json['hasPreviousPage'] as bool? ?? false,
    );
  }
}
