import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/profile_model.dart';
import '../models/bmi_model.dart';

class ProfileRepository {
  final Box<ProfileModel> _profileBox;
  final Box<BMIRecord> _bmiBox;
  final _uuid = const Uuid();

  ProfileRepository(this._profileBox, this._bmiBox);

  // Get all profiles
  List<ProfileModel> getAllProfiles() {
    return _profileBox.values.toList();
  }

  // Get profile by id
  ProfileModel? getProfileById(String id) {
    return _profileBox.get(id);
  }

  // Add new profile
  Future<String> addProfile(ProfileModel profile) async {
    final id = _uuid.v4();
    final now = DateTime.now();

    final newProfile = ProfileModel(
      id: id,
      name: profile.name,
      age: profile.age,
      height: profile.height,
      weight: profile.weight,
      gender: profile.gender,
      createdAt: now,
      updatedAt: now,
    );

    await _profileBox.put(id, newProfile);

    // Add initial BMI record
    await addBMIRecord(newProfile);

    return id;
  }

  // Update profile
  Future<void> updateProfile(ProfileModel profile) async {
    final updatedProfile = profile.copyWith(updatedAt: DateTime.now());

    await _profileBox.put(profile.id, updatedProfile);

    // Add new BMI record
    await addBMIRecord(updatedProfile);
  }

  // Delete profile
  Future<void> deleteProfile(String id) async {
    await _profileBox.delete(id);

    // Delete all BMI records for this profile
    final bmiRecords = getBMIRecordsForProfile(id);
    for (final record in bmiRecords) {
      await _bmiBox.delete(record.id);
    }
  }

  // Add BMI record
  Future<void> addBMIRecord(ProfileModel profile) async {
    final id = _uuid.v4();
    final bmiValue = profile.calculateBMI();
    final category = profile.getBMICategory();

    final bmiRecord = BMIRecord(
      id: id,
      profileId: profile.id,
      weight: profile.weight,
      height: profile.height,
      bmiValue: bmiValue,
      category: category,
      date: DateTime.now(),
    );

    await _bmiBox.put(id, bmiRecord);
  }

  // Get BMI records for a profile
  List<BMIRecord> getBMIRecordsForProfile(String profileId) {
    return _bmiBox.values
        .where((record) => record.profileId == profileId)
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }
}
