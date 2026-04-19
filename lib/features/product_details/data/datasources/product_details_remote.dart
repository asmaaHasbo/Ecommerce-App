import 'package:dio/dio.dart';
import 'package:laza_ecommerce_app/core/error/api_error_handler.dart';
import 'package:laza_ecommerce_app/core/networking/api_end_pontis.dart';
import 'package:laza_ecommerce_app/core/networking/dio_factory.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_item_model.dart';

class ProductDetailsRemote {
  final Dio _dio;

  ProductDetailsRemote() : _dio = DioFactory.getDio();

  Future<ProductItemModel> getProductDetails(String productId) async {
    try {
      final response = await _dio.get(
        '${ApiEndPontis.baseUrl}${ApiEndPontis.products}/$productId',
      );

      return ProductItemModel.fromJson(response.data['data']);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      throw Exception(exception.message);
    }
  }
}
