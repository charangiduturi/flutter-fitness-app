import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'profile_model.g.dart';

@HiveType(typeId: 0)
class ProfileModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int age;

  @HiveField(3)
  final double height; // in cm

  @HiveField(4)
  final double weight; // in kg

  @HiveField(5)
  final String gender; // 'male', 'female', 'other'

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final DateTime updatedAt;

  const ProfileModel({
    required this.id,
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
  });

  double calculateBMI() {
    // BMI = weight(kg) / (height(m) * height(m))
    return weight / ((height / 100) * (height / 100));
  }

  String getBMICategory() {
    final bmi = calculateBMI();
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 25) {
      return 'Normal weight';
    } else if (bmi >= 25 && bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  ProfileModel copyWith({
    String? id,
    String? name,
    int? age,
    double? height,
    double? weight,
    String? gender,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    age,
    height,
    weight,
    gender,
    createdAt,
    updatedAt,
  ];
}
