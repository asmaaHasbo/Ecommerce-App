import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza_ecommerce_app/features/profile/data/models/update_profile_request_model.dart';
import 'package:laza_ecommerce_app/features/profile/data/repositories/profile_repo.dart';
import 'package:laza_ecommerce_app/features/profile/logic/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _repo;

  ProfileCubit(this._repo) : super(Initial());

  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(Loading());

    try {
      final requestModel = UpdateProfileRequestModel(
        name: name,
        email: email,
        phone: phone,
      );

      final response = await _repo.updateProfile(requestModel);

      emit(Success(response.message ?? 'Profile updated successfully'));
    } catch (e) {
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      emit(Failure(errorMessage));
    }
  }
}
