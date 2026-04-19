class ReviewModel {
  String? id;
  String? review;
  int? rating;
  String? productId;
  ReviewUserModel? user;
  String? createdAt;
  String? updatedAt;

  ReviewModel({
    this.id,
    this.review,
    this.rating,
    this.productId,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id'] as String?,
      review: json['review'] as String?,
      rating: json['rating'] as int?,
      productId: json['product'] as String?,
      user: json['user'] != null
          ? ReviewUserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }
}

class ReviewUserModel {
  String? id;
  String? name;

  ReviewUserModel({this.id, this.name});

  factory ReviewUserModel.fromJson(Map<String, dynamic> json) {
    return ReviewUserModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );
  }
}
