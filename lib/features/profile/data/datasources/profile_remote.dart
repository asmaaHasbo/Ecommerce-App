import 'package:dio/dio.dart';
import 'package:laza_ecommerce_app/core/error/api_error_handler.dart';
import 'package:laza_ecommerce_app/core/networking/api_end_pontis.dart';
import 'package:laza_ecommerce_app/core/networking/dio_factory.dart';
import 'package:laza_ecommerce_app/features/profile/data/models/update_profile_request_model.dart';
import 'package:laza_ecommerce_app/features/profile/data/models/update_profile_response_model.dart';

class ProfileRemote {
  final Dio _dio;

  ProfileRemote() : _dio = DioFactory.getDio();

  Future<UpdateProfileResponseModel> updateProfile(
    UpdateProfileRequestModel requestModel,
  ) async {
    try {
      final response = await _dio.put(
        ApiEndPontis.baseUrl + ApiEndPontis.updateProfile,
        data: requestModel.toJson(),
      );

      return UpdateProfileResponseModel.fromJson(response.data);
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      throw Exception(exception.message);
    }
  }
}
