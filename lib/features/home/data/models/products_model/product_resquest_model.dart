class ProductResquestModel {
  dynamic searchTerm;
  dynamic category;
  dynamic minPrice;
  dynamic maxPrice;
  dynamic isInStock;
  dynamic sortBy;
  dynamic sortOrder;
  int page;
  int limit;

  ProductResquestModel({
    required this.searchTerm,
    required this.category,
    required this.minPrice,
    required this.maxPrice,
    required this.isInStock,
    required this.sortBy,
    required this.sortOrder,
    required this.page,
    required this.limit,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    
    if (searchTerm != null) map['searchTerm'] = searchTerm;
    if (category != null) map['category'] = category;
    if (minPrice != null) map['minPrice'] = minPrice;
    if (maxPrice != null) map['maxPrice'] = maxPrice;
    if (isInStock != null) map['isInStock'] = isInStock;
    if (sortBy != null) map['sortBy'] = sortBy;
    if (sortOrder != null) map['sortOrder'] = sortOrder;
    map['page'] = page;
    // Don't send limit to get all products
    // if (limit != null) map['limit'] = limit;
    
    return map;
  }
}
