import 'package:laza_ecommerce_app/features/auth/forget_password/data/datasources/reset_password_remote.dart';
import 'package:laza_ecommerce_app/features/auth/forget_password/data/models/reset_password_response_model.dart';

class ResetPasswordRepo {
  final ResetPasswordRemote _remote;

  ResetPasswordRepo(this._remote);

  Future<ResetPasswordResponseModel> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    return await _remote.resetPassword(
      email: email,
      newPassword: newPassword,
    );
  }
}
