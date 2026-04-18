import 'package:dio/dio.dart';
import 'package:laza_ecommerce_app/core/error/api_error_handler.dart';
import 'package:laza_ecommerce_app/core/networking/api_end_pontis.dart';
import 'package:laza_ecommerce_app/core/networking/dio_factory.dart';
import 'package:laza_ecommerce_app/features/cart/data/models/add_cart_response_model.dart';
import 'package:laza_ecommerce_app/features/cart/data/models/cart_products_model/cart_products_model.dart';

class CartRemote {
  final Dio _dio;

  CartRemote() : _dio = DioFactory.getDio();

  //========== add to cart ==========//
  Future<AddCartResponseModel> addToCart({
    required String productId,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiEndPontis.baseUrlV2}${ApiEndPontis.cart}',
        data: {'productId': productId},
      );

      return AddCartResponseModel.fromJson(response.data);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      throw Exception(exception.message);
    }
  }

  //========== get cart ==========//
  Future<CartProductsModel> getCart() async {
    try {
      final response = await _dio.get(
        '${ApiEndPontis.baseUrlV2}${ApiEndPontis.cart}',
      );

      return CartProductsModel.fromJson(response.data);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      throw Exception(exception.message);
    }
  }

  //========== update cart quantity ==========//
  Future<CartProductsModel> updateCartQuantity({
    required String productId,
    required int count,
  }) async {
    try {
      final response = await _dio.put(
        '${ApiEndPontis.baseUrlV2}${ApiEndPontis.cart}/$productId',
        data: {'count': count},
      );

      return CartProductsModel.fromJson(response.data);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      throw Exception(exception.message);
    }
  }

  //========== delete from cart ==========//
  Future<CartProductsModel> deleteFromCart(String itemId) async {
    try {
      final response = await _dio.delete(
        '${ApiEndPontis.baseUrlV2}${ApiEndPontis.cart}/$itemId',
      );

      return CartProductsModel.fromJson(response.data);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      throw Exception(exception.message);
    }
  }
}
