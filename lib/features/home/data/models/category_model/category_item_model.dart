class CategoryItemModel {
  String? id;
  String? name;
  String? description;
  String? coverPictureUrl;

  CategoryItemModel({
    this.id,
    this.name,
    this.description,
    this.coverPictureUrl,
  });

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) =>
      CategoryItemModel(
        id: json['id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        coverPictureUrl: json['coverPictureUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'coverPictureUrl': coverPictureUrl,
  };
}
