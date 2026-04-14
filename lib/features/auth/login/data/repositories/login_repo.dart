import 'package:laza_ecommerce_app/features/auth/login/data/datasources/login_remote.dart';
import 'package:laza_ecommerce_app/features/auth/login/data/models/login_response_model.dart';
import 'package:laza_ecommerce_app/features/auth/login/data/models/login_resquest_model.dart';

class LoginRepo {
  final LoginRemote _remote;
  LoginRepo(this._remote);

  Future<LoginResponseModel> loginRepoFunction(
    LoginRequestModel loginRequestModel,
  ) async {
    return await _remote.loginRequest(loginRequestModel);
  }
}
