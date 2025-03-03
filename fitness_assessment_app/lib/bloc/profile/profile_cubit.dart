import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/profile_repository.dart';
import '../../models/profile_model.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;

  ProfileCubit(this._repository) : super(const ProfileState());

  void loadProfiles() {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final profiles = _repository.getAllProfiles();
      emit(state.copyWith(status: ProfileStatus.loaded, profiles: profiles));
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.error, error: e.toString()));
    }
  }

  void selectProfile(String id) {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final profile = _repository.getProfileById(id);
      if (profile != null) {
        final bmiRecords = _repository.getBMIRecordsForProfile(id);
        emit(
          state.copyWith(
            status: ProfileStatus.loaded,
            selectedProfile: profile,
            bmiRecords: bmiRecords,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ProfileStatus.error,
            error: 'Profile not found',
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.error, error: e.toString()));
    }
  }

  Future<void> addProfile(ProfileModel profile) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      await _repository.addProfile(profile);
      loadProfiles();
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.error, error: e.toString()));
    }
  }

  Future<void> updateProfile(ProfileModel profile) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      await _repository.updateProfile(profile);
      selectProfile(profile.id);
      loadProfiles();
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.error, error: e.toString()));
    }
  }

  Future<void> deleteProfile(String id) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      await _repository.deleteProfile(id);
      emit(
        state.copyWith(
          status: ProfileStatus.loaded,
          selectedProfile: null,
          bmiRecords: [],
        ),
      );
      loadProfiles();
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.error, error: e.toString()));
    }
  }
}
