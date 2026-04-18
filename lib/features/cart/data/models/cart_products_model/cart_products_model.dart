import 'package:laza_ecommerce_app/features/cart/data/models/cart_products_model/cart_item_model.dart';


class CartProductsModel {
  String? status;
  String? message;
  int? numOfCartItems;
  String? cartId;
  List<CartItemModel>? cartItems;
  int? totalCartPrice;

  CartProductsModel({
    this.status,
    this.message,
    this.numOfCartItems,
    this.cartId,
    this.cartItems,
    this.totalCartPrice,
  });

  factory CartProductsModel.fromJson(Map<String, dynamic> json) {
    return CartProductsModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      numOfCartItems: json['numOfCartItems'] as int?,
      cartId: json['cartId'] as String?,
      cartItems: (json['data']?['products'] as List<dynamic>?)
          ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCartPrice: json['data']?['totalCartPrice'] as int?,
    );
  }
}
