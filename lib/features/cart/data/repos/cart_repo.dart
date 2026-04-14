import 'dart:developer';

import 'package:laza_ecommerce_app/core/error/api_error_handler.dart';
import 'package:laza_ecommerce_app/core/networking/api_result.dart';
import 'package:laza_ecommerce_app/features/cart/data/api/cart_api_service.dart';
import 'package:laza_ecommerce_app/features/cart/data/models/add_cart_request_model.dart';
import 'package:laza_ecommerce_app/features/cart/data/models/add_cart_response_model.dart';
import 'package:laza_ecommerce_app/features/cart/data/models/cart_products_model/cart_products_model.dart';

class CartRepo {
  final CartApiService _cartApiService;

  CartRepo(this._cartApiService);
  
  //========================== add item to cart ==========
  Future<ApiResult<AddCartResponseModel>> addItemToCart(
    AddCartRequestModel addCartRequestModel,
  ) async {
    try {
      final response = await _cartApiService.addProductToCart(
        addCartRequestModel,
      );
      return ApiResult.success(response);
    } catch (e) {
      log('Add to cart error: ${e.toString()}');
      final exception = ApiErrorHandler.handle(e);
      return ApiResult.failure(exception.message);
    }
  }

  //========================== get item from cart ==========
  Future<ApiResult<CartProductsModel>> getCartProducts() async {
    try {
      final response = await _cartApiService.getCartProducts();
      log("response from repo is ${response.cartItems?.length} ");
      return ApiResult.success(response);
    } catch (e) {
      log('Get cart products error: ${e.toString()}');
      final exception = ApiErrorHandler.handle(e);
      return ApiResult.failure(exception.message);
    }
  }

  //========================== delete item from cart ==========
  Future<ApiResult> deleteCartProducts({required String itemId}) async {
    try {
      await _cartApiService.deleteProduct(itemId, {'id': itemId});
      log("item deleted ");
      return ApiResult.success('Item deleted successfully');
    } catch (e) {
      log('Delete cart item error: ${e.toString()}');
      final exception = ApiErrorHandler.handle(e);
      return ApiResult.failure(exception.message);
    }
  }
}
