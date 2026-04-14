import 'package:dio/dio.dart';
import 'package:laza_ecommerce_app/core/error/api_error_handler.dart';
import 'package:laza_ecommerce_app/core/networking/api_end_pontis.dart';
import 'package:laza_ecommerce_app/core/networking/dio_factory.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/data/models/sign_up_request_model.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/data/models/sign_up_response_model.dart';

class SignUpRemote {
  final Dio _dio;

  SignUpRemote() : _dio = DioFactory.getDio();

  Future<SignUpResponseModel> signUpRequest(SignUpRequestModel signUpRequestModel) async {
    try {
      final response = await _dio.post(
        ApiEndPontis.baseUrl + ApiEndPontis.signUp,
        data: signUpRequestModel.toJson(),
      );

      return SignUpResponseModel.fromJson(response.data);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      throw Exception(exception.message);
    }
  }
}
