// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmi_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BMIRecordAdapter extends TypeAdapter<BMIRecord> {
  @override
  final int typeId = 1;

  @override
  BMIRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BMIRecord(
      id: fields[0] as String,
      profileId: fields[1] as String,
      weight: fields[2] as double,
      height: fields[3] as double,
      bmiValue: fields[4] as double,
      category: fields[5] as String,
      date: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BMIRecord obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.profileId)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.bmiValue)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BMIRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
