import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'bmi_model.g.dart';

@HiveType(typeId: 1)
class BMIRecord extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String profileId;

  @HiveField(2)
  final double weight;

  @HiveField(3)
  final double height;

  @HiveField(4)
  final double bmiValue;

  @HiveField(5)
  final String category;

  @HiveField(6)
  final DateTime date;

  const BMIRecord({
    required this.id,
    required this.profileId,
    required this.weight,
    required this.height,
    required this.bmiValue,
    required this.category,
    required this.date,
  });

  @override
  List<Object?> get props => [
    id,
    profileId,
    weight,
    height,
    bmiValue,
    category,
    date,
  ];
}
