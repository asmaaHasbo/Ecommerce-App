import 'package:dio/dio.dart';
import 'package:laza_ecommerce_app/core/error/api_error_handler.dart';
import 'package:laza_ecommerce_app/core/networking/api_end_pontis.dart';
import 'package:laza_ecommerce_app/core/networking/dio_factory.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/models/reset_password_response_model.dart';

class ResetPasswordRemote {
  final Dio _dio;

  ResetPasswordRemote() : _dio = DioFactory.getDio();

  Future<ResetPasswordResponseModel> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.put(
        ApiEndPontis.baseUrl + ApiEndPontis.resetPassword,
        data: {
          'email': email,
          'newPassword': newPassword,
        },
      );

      return ResetPasswordResponseModel.fromJson(response.data);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      throw Exception(exception.message);
    }
  }
}
