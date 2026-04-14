import 'package:laza_ecommerce_app/features/auth/forget_password/data/datasources/forget_password_remote.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/models/forget_password_response_model.dart';

class ForgetPasswordRepo {
  final ForgetPasswordRemote _remote;

  ForgetPasswordRepo(this._remote);

  Future<ForgetPasswordResponseModel> sendResetCode(String email) async {
    return await _remote.sendResetCode(email);
  }
}
