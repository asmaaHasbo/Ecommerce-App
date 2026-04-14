import 'package:laza_ecommerce_app/features/auth/forget_password/data/datasources/forget_password_remote.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/datasources/verify_reset_code_remote.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/models/forget_password_response_model.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/models/verify_reset_code_response_model.dart';

class VerifyResetCodeRepo {
  final VerifyResetCodeRemote _remote;
  final ForgetPasswordRemote _forgetPasswordRemote;

  VerifyResetCodeRepo(this._remote, this._forgetPasswordRemote);

  Future<VerifyResetCodeResponseModel> verifyResetCode(String resetCode) async {
    return await _remote.verifyResetCode(resetCode);
  }

  Future<ForgetPasswordResponseModel> resendResetCode(String email) async {
    return await _forgetPasswordRemote.sendResetCode(email);
  }
}
