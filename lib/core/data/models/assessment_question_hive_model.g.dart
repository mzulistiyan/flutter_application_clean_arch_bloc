// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_question_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionHiveModelAdapter extends TypeAdapter<QuestionHiveModel> {
  @override
  final int typeId = 2;

  @override
  QuestionHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionHiveModel(
      questionid: fields[0] as String?,
      section: fields[1] as String?,
      number: fields[2] as String?,
      type: fields[3] as String?,
      questionName: fields[4] as String?,
      scoring: fields[5] as bool?,
      options: (fields[6] as List?)?.cast<OptionHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuestionHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.questionid)
      ..writeByte(1)
      ..write(obj.section)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.questionName)
      ..writeByte(5)
      ..write(obj.scoring)
      ..writeByte(6)
      ..write(obj.options);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
