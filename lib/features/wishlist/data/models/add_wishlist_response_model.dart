class AddWishlistResponseModel {
  final String? status;
  final String? message;
  final List<String>? data;

  AddWishlistResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory AddWishlistResponseModel.fromJson(Map<String, dynamic> json) {
    return AddWishlistResponseModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? (json['data'] as List).map((item) => item.toString()).toList()
          : null,
    );
  }

  /// Get product IDs from the response
  List<String> getProductIds() {
    return data ?? [];
  }
}
