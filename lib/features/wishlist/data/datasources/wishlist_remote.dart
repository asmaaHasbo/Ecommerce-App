import 'package:dio/dio.dart';
import 'package:laza_ecommerce_app/core/error/api_error_handler.dart';
import 'package:laza_ecommerce_app/core/networking/api_end_pontis.dart';
import 'package:laza_ecommerce_app/core/networking/dio_factory.dart';
import 'package:laza_ecommerce_app/features/wishlist/data/models/add_wishlist_response_model.dart';
import 'package:laza_ecommerce_app/features/wishlist/data/models/remove_wishlist_response_model.dart';
import 'package:laza_ecommerce_app/features/wishlist/data/models/wishlist_response_model.dart';

class WishlistRemote {
  final Dio _dio;

  WishlistRemote() : _dio = DioFactory.getDio();

  //========== add to wishlist ==========//
  Future<AddWishlistResponseModel> addToWishlist(String productId) async {
    try {
      final response = await _dio.post(
        ApiEndPontis.baseUrl + ApiEndPontis.wishlist,
        data: {'productId': productId},
      );

      return AddWishlistResponseModel.fromJson(response.data);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      throw Exception(exception.message);
    }
  }

  //========== get wishlist ==========//
  Future<WishlistResponseModel> getWishlist() async {
    try {
      final response = await _dio.get(
        ApiEndPontis.baseUrl + ApiEndPontis.wishlist,
      );

      return WishlistResponseModel.fromJson(response.data);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      throw Exception(exception.message);
    }
  }

  //========== remove from wishlist ==========//
  Future<RemoveWishlistResponseModel> removeFromWishlist(String productId) async {
    try {
      final response = await _dio.delete(
        '${ApiEndPontis.baseUrl}${ApiEndPontis.wishlist}/$productId',
      );

      return RemoveWishlistResponseModel.fromJson(response.data);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      throw Exception(exception.message);
    }
  }
}
