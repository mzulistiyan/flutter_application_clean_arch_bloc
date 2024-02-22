// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_request_hive_assessment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BodyReqHiveAssesmentAdapter extends TypeAdapter<BodyReqHiveAssesment> {
  @override
  final int typeId = 4;

  @override
  BodyReqHiveAssesment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BodyReqHiveAssesment(
      assessmentId: fields[0] as String?,
      answers: (fields[1] as List?)?.cast<AnswerHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, BodyReqHiveAssesment obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.assessmentId)
      ..writeByte(1)
      ..write(obj.answers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyReqHiveAssesmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AnswerHiveAdapter extends TypeAdapter<AnswerHive> {
  @override
  final int typeId = 5;

  @override
  AnswerHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnswerHive(
      questionId: fields[0] as String?,
      answer: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AnswerHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.questionId)
      ..writeByte(1)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswerHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
