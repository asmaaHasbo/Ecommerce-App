class RemoveWishlistResponseModel {
  final String? status;
  final String? message;
  final List<String>? data;

  RemoveWishlistResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory RemoveWishlistResponseModel.fromJson(Map<String, dynamic> json) {
    return RemoveWishlistResponseModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? (json['data'] as List).map((item) => item.toString()).toList()
          : null,
    );
  }
}
