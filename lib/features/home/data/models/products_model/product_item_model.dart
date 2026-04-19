import 'package:laza_ecommerce_app/features/home/data/models/products_model/review_model.dart';

class ProductItemModel {
  int? sold;
  List<String>? images;
  List<SubcategoryModel>? subcategory;
  int? ratingsQuantity;
  String? id;
  String? title;
  String? slug;
  String? description;
  int? quantity;
  int? price;
  String? imageCover;
  CategoryModel? category;
  BrandModel? brand;
  double? ratingsAverage;
  String? createdAt;
  String? updatedAt;
  List<ReviewModel>? reviews;

  ProductItemModel({
    this.sold,
    this.images,
    this.subcategory,
    this.ratingsQuantity,
    this.id,
    this.title,
    this.slug,
    this.description,
    this.quantity,
    this.price,
    this.imageCover,
    this.category,
    this.brand,
    this.ratingsAverage,
    this.createdAt,
    this.updatedAt,
    this.reviews,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    return ProductItemModel(
      sold: json['sold'] as int?,
      images: (json['images'] as List<dynamic>?)?.cast<String>(),
      subcategory: (json['subcategory'] as List<dynamic>?)
          ?.map((e) => SubcategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      ratingsQuantity: json['ratingsQuantity'] as int?,
      id: json['_id'] as String? ?? json['id'] as String?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      quantity: json['quantity'] as int?,
      price: json['price'] as int?,
      imageCover: json['imageCover'] as String?,
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      brand: json['brand'] != null
          ? BrandModel.fromJson(json['brand'] as Map<String, dynamic>)
          : null,
      ratingsAverage: (json['ratingsAverage'] as num?)?.toDouble(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SubcategoryModel {
  String? id;
  String? name;
  String? slug;
  String? category;

  SubcategoryModel({this.id, this.name, this.slug, this.category});

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      category: json['category'] as String?,
    );
  }
}

class CategoryModel {
  String? id;
  String? name;
  String? slug;
  String? image;

  CategoryModel({this.id, this.name, this.slug, this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      image: json['image'] as String?,
    );
  }
}

class BrandModel {
  String? id;
  String? name;
  String? slug;
  String? image;

  BrandModel({this.id, this.name, this.slug, this.image});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      image: json['image'] as String?,
    );
  }
}
