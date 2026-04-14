import 'package:laza_ecommerce_app/features/auth/sign_up/data/datasources/sign_up_remote.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/data/models/sign_up_request_model.dart';
import 'package:laza_ecommerce_app/features/auth/sign_up/data/models/sign_up_response_model.dart';

class SignUpRepo {
  final SignUpRemote _remote;
  SignUpRepo(this._remote);

  Future<SignUpResponseModel> signUpRepoFunction(
    SignUpRequestModel signUpRequestModel,
  ) async {
    return await _remote.signUpRequest(signUpRequestModel);
  }
}
