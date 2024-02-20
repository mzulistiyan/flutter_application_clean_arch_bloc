// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_detail_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssessmentDetailResponseHiveAdapter
    extends TypeAdapter<AssessmentDetailResponseHive> {
  @override
  final int typeId = 3;

  @override
  AssessmentDetailResponseHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssessmentDetailResponseHive(
      id: fields[0] as String?,
      name: fields[1] as String?,
      question: (fields[2] as List?)?.cast<QuestionHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, AssessmentDetailResponseHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.question);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssessmentDetailResponseHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
