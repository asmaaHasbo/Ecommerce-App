import 'package:laza_ecommerce_app/features/profile/data/datasources/profile_remote.dart';
import 'package:laza_ecommerce_app/features/profile/data/models/update_profile_request_model.dart';
import 'package:laza_ecommerce_app/features/profile/data/models/update_profile_response_model.dart';

class ProfileRepo {
  final ProfileRemote _remote;
  ProfileRepo(this._remote);

  Future<UpdateProfileResponseModel> updateProfile(
    UpdateProfileRequestModel requestModel,
  ) async {
    return await _remote.updateProfile(requestModel);
  }
}
