import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_item_model.dart';

class ProductsModel {
  int? results;
  MetadataModel? metadata;
  List<ProductItemModel>? data;

  ProductsModel({
    this.results,
    this.metadata,
    this.data,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      results: json['results'] as int?,
      metadata: json['metadata'] != null
          ? MetadataModel.fromJson(json['metadata'] as Map<String, dynamic>)
          : null,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => ProductItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class MetadataModel {
  int? currentPage;
  int? numberOfPages;
  int? limit;
  int? nextPage;

  MetadataModel({
    this.currentPage,
    this.numberOfPages,
    this.limit,
    this.nextPage,
  });

  factory MetadataModel.fromJson(Map<String, dynamic> json) {
    return MetadataModel(
      currentPage: json['currentPage'] as int?,
      numberOfPages: json['numberOfPages'] as int?,
      limit: json['limit'] as int?,
      nextPage: json['nextPage'] as int?,
    );
  }
}
