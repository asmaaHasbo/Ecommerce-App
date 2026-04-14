class ProductItemModel {
  String? id;
  String? productCode;
  String? name;
  String? description;
  String? arabicName;
  String? arabicDescription;
  String? coverPictureUrl;
  dynamic productPictures;
  double? price;
  int? stock;
  double? weight;
  String? color;
  double?
  rating; // غيرته من int? إلى double? عشان الـ response بيبعت rating كـ double (مثل 3.3333333)
  int? reviewsCount;
  int? discountPercentage;
  String? sellerId;
  List<String>? categories;

  ProductItemModel({
    this.id,
    this.productCode,
    this.name,
    this.description,
    this.arabicName,
    this.arabicDescription,
    this.coverPictureUrl,
    this.productPictures,
    this.price,
    this.stock,
    this.weight,
    this.color,
    this.rating,
    this.reviewsCount,
    this.discountPercentage,
    this.sellerId,
    this.categories,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    return ProductItemModel(
      id: json['id'] as String?,
      productCode: json['productCode'] as String?,
      name: json['name'] as String? ?? 'Unknown', // إضافة fallback
      description: json['description'] as String? ?? '',
      arabicName: json['arabicName'] as String? ?? '',
      arabicDescription: json['arabicDescription'] as String? ?? '',
      coverPictureUrl: json['coverPictureUrl'] as String? ?? '',
      productPictures: json['productPictures'],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] as int? ?? 0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      color: json['color'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0, // تحويل إلى double
      reviewsCount: json['reviewsCount'] as int? ?? 0,
      discountPercentage: json['discountPercentage'] as int? ?? 0,
      sellerId: json['sellerId'] as String? ?? '',
      categories: (json['categories'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'productCode': productCode,
    'name': name,
    'description': description,
    'arabicName': arabicName,
    'arabicDescription': arabicDescription,
    'coverPictureUrl': coverPictureUrl,
    'productPictures': productPictures,
    'price': price,
    'stock': stock,
    'weight': weight,
    'color': color,
    'rating': rating,
    'reviewsCount': reviewsCount,
    'discountPercentage': discountPercentage,
    'sellerId': sellerId,
    'categories': categories,
  };
}
