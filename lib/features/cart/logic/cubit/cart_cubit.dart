import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/features/cart/data/models/add_cart_response_model.dart';
import 'package:laza_ecommerce_app/features/cart/data/models/cart_products_model/cart_products_model.dart';
import 'package:laza_ecommerce_app/features/cart/data/repos/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo _cartRepo;
  final Set<String> _cartProductIds = {};

  CartCubit(this._cartRepo) : super(CartInitial());

  //===================== check if product in cart =========
  bool isProductInCart(String productId) {
    return _cartProductIds.contains(productId);
  }

  //===================== add product to cart =========
  Future<void> addProductToCart({required String productId}) async {
    if (isProductInCart(productId)) {
      emit(AddCartFailure(errMsg: 'Product already in cart'));
      return;
    }

    emit(AddCartLoading());
    try {
      final response = await _cartRepo.addItemToCart(
        productId: productId,
        quantity: 1,
      );
      _cartProductIds.add(productId);
      log('Product added to cart successfully');
      emit(AddCartSuccess(
        addCartResponseModel: response,
        message: response.message ?? 'Product added to cart',
      ));
    } catch (e) {
      log('Add to cart error: ${e.toString()}');
      emit(AddCartFailure(errMsg: e.toString().replaceAll('Exception: ', '')));
    }
  }

  //========================= get cart products =========
  Future<void> getCartProducts() async {
    emit(GetCartLoading());
    try {
      final response = await _cartRepo.getCartProducts();
      _cartProductIds.clear();
      if (response.cartItems != null) {
        for (var item in response.cartItems!) {
          if (item.productId != null) {
            _cartProductIds.add(item.productId!);
          }
        }
      }
      log('Cart items: ${response.cartItems?.length}');
      emit(GetCartSuccess(cartProductsModel: response));
    } catch (e) {
      log('Get cart error: ${e.toString()}');
      emit(GetCartFailure(errMsg: e.toString().replaceAll('Exception: ', '')));
    }
  }

  //========================= update quantity =========
  Future<void> updateCartQuantity({
    required String productId,
    required int count,
  }) async {
    try {
      final response = await _cartRepo.updateCartQuantity(
        productId: productId,
        count: count,
      );
      log('Quantity updated successfully');
      emit(UpdateCartSuccess(cartProductsModel: response));
    } catch (e) {
      log('Update quantity error: ${e.toString()}');
      emit(UpdateCartFailure(errMsg: e.toString().replaceAll('Exception: ', '')));
    }
  }

  //========================= delete product =========
  Future<void> deleteProductFromCart({required String itemId}) async {
    try {
      final response = await _cartRepo.deleteCartProduct(itemId: itemId);
      _cartProductIds.clear();
      if (response.cartItems != null) {
        for (var item in response.cartItems!) {
          if (item.productId != null) {
            _cartProductIds.add(item.productId!);
          }
        }
      }
      log('Item deleted successfully');
      emit(DelCartSuccess(
        cartProductsModel: response,
        message: response.message ?? 'Item removed from cart',
      ));
    } catch (e) {
      log('Delete item error: ${e.toString()}');
      emit(DelCartFailure(errMsg: e.toString().replaceAll('Exception: ', '')));
    }
  }
}
