import 'package:dio/dio.dart';
import 'package:laza_ecommerce_app/core/error/api_error_handler.dart';
import 'package:laza_ecommerce_app/core/networking/api_end_pontis.dart';
import 'package:laza_ecommerce_app/core/networking/dio_factory.dart';
import 'package:laza_ecommerce_app/features/auth/login/data/models/login_response_model.dart';
import 'package:laza_ecommerce_app/features/auth/login/data/models/login_resquest_model.dart';

class LoginRemote {
  final Dio _dio;

  LoginRemote() : _dio = DioFactory.getDio();

  Future<LoginResponseModel> loginRequest(LoginRequestModel loginRequestModel) async {
    try {
      final response = await _dio.post(
        ApiEndPontis.baseUrl + ApiEndPontis.login,
        data: loginRequestModel.toJson(),
      );

      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      throw Exception(exception.message);
    }
  }
}
