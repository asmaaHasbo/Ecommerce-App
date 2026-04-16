class PaginationMetadata {
  int? currentPage; // الصفحة الحالية
  int? numberOfPages; // عدد الصفحات الكلي
  int? limit; // عدد العناصر في كل صفحة

  PaginationMetadata({
    this.currentPage,
    this.numberOfPages,
    this.limit,
  });

  factory PaginationMetadata.fromJson(Map<String, dynamic> json) =>
      PaginationMetadata(
        currentPage: json['currentPage'] as int?,
        numberOfPages: json['numberOfPages'] as int?,
        limit: json['limit'] as int?,
      );

  Map<String, dynamic> toJson() => {
    'currentPage': currentPage,
    'numberOfPages': numberOfPages,
    'limit': limit,
  };
}
