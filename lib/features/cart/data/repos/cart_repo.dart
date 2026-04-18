import 'package:laza_ecommerce_app/features/cart/data/datasources/cart_remote.dart';
import 'package:laza_ecommerce_app/features/cart/data/models/add_cart_response_model.dart';
import 'package:laza_ecommerce_app/features/cart/data/models/cart_products_model/cart_products_model.dart';

class CartRepo {
  final CartRemote _cartRemote;

  CartRepo(this._cartRemote);

  //========================== add item to cart ==========
  Future<AddCartResponseModel> addItemToCart({
    required String productId,
    required int quantity,
  }) async {
    return await _cartRemote.addToCart(
      productId: productId,
    );
  }

  //========================== get cart products ==========
  Future<CartProductsModel> getCartProducts() async {
    return await _cartRemote.getCart();
  }

  //========================== update cart quantity ==========
  Future<CartProductsModel> updateCartQuantity({
    required String productId,
    required int count,
  }) async {
    return await _cartRemote.updateCartQuantity(
      productId: productId,
      count: count,
    );
  }

  //========================== delete item from cart ==========
  Future<CartProductsModel> deleteCartProduct({
    required String itemId,
  }) async {
    return await _cartRemote.deleteFromCart(itemId);
  }
}
