import 'package:laza_ecommerce_app/features/home/data/models/category_model/category_item_model.dart';
import 'package:laza_ecommerce_app/features/home/data/models/category_model/pagination_metadata.dart';

class CategoriesModel {
  int? results; // عدد النتائج الكلي
  PaginationMetadata? metadata; // معلومات الـ pagination
  List<CategoryItemModel>? categories; // قائمة الـ categories

  CategoriesModel({
    this.results,
    this.metadata,
    this.categories,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        results: json['results'] as int?,
        metadata: json['metadata'] != null
            ? PaginationMetadata.fromJson(json['metadata'] as Map<String, dynamic>)
            : null,
        categories: (json['data'] as List<dynamic>?)
            ?.map((e) => CategoryItemModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    'results': results,
    'metadata': metadata?.toJson(),
    'data': categories?.map((e) => e.toJson()).toList(),
  };
}
