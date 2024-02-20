// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_option_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OptionHiveModelAdapter extends TypeAdapter<OptionHiveModel> {
  @override
  final int typeId = 1;

  @override
  OptionHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OptionHiveModel(
      optionid: fields[0] as String?,
      optionName: fields[1] as String?,
      points: fields[2] as int?,
      flag: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, OptionHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.optionid)
      ..writeByte(1)
      ..write(obj.optionName)
      ..writeByte(2)
      ..write(obj.points)
      ..writeByte(3)
      ..write(obj.flag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
