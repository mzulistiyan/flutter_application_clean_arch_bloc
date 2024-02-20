// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssessmentHiveModelAdapter extends TypeAdapter<AssessmentHiveModel> {
  @override
  final int typeId = 0;

  @override
  AssessmentHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssessmentHiveModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
      assessmentDate: fields[2] as DateTime?,
      description: fields[3] as String?,
      type: fields[4] as String?,
      createdAt: fields[5] as DateTime?,
      lastDownloaded: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, AssessmentHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.assessmentDate)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.lastDownloaded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssessmentHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
