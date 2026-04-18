class AddCartResponseModel {
  String? status;
  String? message;
  int? numOfCartItems;
  String? cartId;

  AddCartResponseModel({
    this.status,
    this.message,
    this.numOfCartItems,
    this.cartId,
  });

  factory AddCartResponseModel.fromJson(Map<String, dynamic> json) {
    return AddCartResponseModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      numOfCartItems: json['numOfCartItems'] as int?,
      cartId: json['cartId'] as String?,
    );
  }
}
