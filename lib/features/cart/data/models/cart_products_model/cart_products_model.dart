import 'cart_item.dart';

class CartProductsModel {
  String? cartId;
  List<CartItemModel>? cartItems;

  CartProductsModel({this.cartId, this.cartItems});

  factory CartProductsModel.fromJson(Map<String, dynamic> json) {
    return CartProductsModel(
      cartId: json['cartId'] as String?,
      cartItems: (json['cartItems'] as List<dynamic>?)
          ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
