import 'package:dio/dio.dart';
import 'package:laza_ecommerce_app/core/error/api_error_handler.dart';
import 'package:laza_ecommerce_app/core/networking/api_end_pontis.dart';
import 'package:laza_ecommerce_app/core/networking/dio_factory.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/models/verify_reset_code_response_model.dart';

class VerifyResetCodeRemote {
  final Dio _dio;

  VerifyResetCodeRemote() : _dio = DioFactory.getDio();

  Future<VerifyResetCodeResponseModel> verifyResetCode(String resetCode) async {
    try {
      final response = await _dio.post(
        ApiEndPontis.baseUrl + ApiEndPontis.verifyResetCode,
        data: {
          'resetCode': resetCode,
        },
      );

      return VerifyResetCodeResponseModel.fromJson(response.data);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      throw Exception(exception.message);
    }
  }
}
