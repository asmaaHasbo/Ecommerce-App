import 'package:laza_ecommerce_app/features/home/data/models/category_model/category_item_model.dart';

class CategoriesModel {
  List<CategoryItemModel>? categories;

  CategoriesModel({this.categories});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        categories: (json['categories'] as List<dynamic>?)
            ?.map((e) => CategoryItemModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    'categories': categories?.map((e) => e.toJson()).toList(),
  };
}
