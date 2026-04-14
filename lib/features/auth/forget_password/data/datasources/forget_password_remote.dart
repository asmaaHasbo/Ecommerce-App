import 'package:dio/dio.dart';
import 'package:laza_ecommerce_app/core/error/api_error_handler.dart';
import 'package:laza_ecommerce_app/core/networking/api_end_pontis.dart';
import 'package:laza_ecommerce_app/core/networking/dio_factory.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/models/forget_password_response_model.dart';

class ForgetPasswordRemote {
  final Dio _dio;

  ForgetPasswordRemote() : _dio = DioFactory.getDio();

  Future<ForgetPasswordResponseModel> sendResetCode(String email) async {
    try {
      final response = await _dio.post(
        ApiEndPontis.baseUrl + ApiEndPontis.forgotPassword,
        data: {
          'email': email,
        },
      );

      return ForgetPasswordResponseModel.fromJson(response.data);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      throw Exception(exception.message);
    }
  }
}
