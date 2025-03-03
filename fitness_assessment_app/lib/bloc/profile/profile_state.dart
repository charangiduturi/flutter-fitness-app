import 'package:equatable/equatable.dart';
import '../../models/profile_model.dart';
import '../../models/bmi_model.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final List<ProfileModel> profiles;
  final ProfileModel? selectedProfile;
  final List<BMIRecord> bmiRecords;
  final String? error;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profiles = const [],
    this.selectedProfile,
    this.bmiRecords = const [],
    this.error,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    List<ProfileModel>? profiles,
    ProfileModel? selectedProfile,
    List<BMIRecord>? bmiRecords,
    String? error,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profiles: profiles ?? this.profiles,
      selectedProfile: selectedProfile ?? this.selectedProfile,
      bmiRecords: bmiRecords ?? this.bmiRecords,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    profiles,
    selectedProfile,
    bmiRecords,
    error,
  ];
}
