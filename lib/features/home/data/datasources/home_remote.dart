import 'package:dio/dio.dart';
import 'package:laza_ecommerce_app/core/error/api_error_handler.dart';
import 'package:laza_ecommerce_app/core/networking/api_end_pontis.dart';
import 'package:laza_ecommerce_app/core/networking/dio_factory.dart';
import 'package:laza_ecommerce_app/features/home/data/models/category_model/categories_model.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/product_resquest_model.dart';
import 'package:laza_ecommerce_app/features/home/data/models/products_model/products_model.dart';

class HomeRemote {
  final Dio _dio;

  HomeRemote() : _dio = DioFactory.getDio();

  Future<CategoriesModel> getCategories() async {
    try {
      final response = await _dio.get(
        ApiEndPontis.baseUrl + ApiEndPontis.categories,
      );

      return CategoriesModel.fromJson(response.data);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      throw Exception(exception.message);
    }
  }

  Future<ProductsModel> getProducts(ProductResquestModel productResquestModel) async {
    try {
      final response = await _dio.get(
        ApiEndPontis.baseUrl + ApiEndPontis.products,
        queryParameters: productResquestModel.toJson(),
      );

      return ProductsModel.fromJson(response.data);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      throw Exception(exception.message);
    }
  }
}
