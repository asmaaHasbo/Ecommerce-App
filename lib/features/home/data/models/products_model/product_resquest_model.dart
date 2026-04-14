class ProductResquestModel {
  dynamic searchTerm;
  dynamic category;
  dynamic minPrice;
  dynamic maxPrice;
  dynamic isInStock;
  dynamic sortBy;
  dynamic sortOrder;
  int page;
  int pageSize;

  ProductResquestModel({
    required this.searchTerm,
    required this.category,
    required this.minPrice,
    required this.maxPrice,
    required this.isInStock,
    required this.sortBy,
    required this.sortOrder,
    required this.page,
    required this.pageSize,
  });

  Map<String, dynamic> toJson() => {
    'searchTerm': searchTerm,
    'category': category,
    'minPrice': minPrice,
    'maxPrice': maxPrice,
    'isInStock': isInStock,
    'sortBy': sortBy,
    'sortOrder': sortOrder,
    'page': page,
    'pageSize': pageSize,
  };
}
