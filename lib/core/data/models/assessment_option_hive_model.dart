import 'package:hive/hive.dart';
import '../../core.dart';

part 'assessment_option_hive_model.g.dart'; // Hive generator akan menghasilkan file ini

@HiveType(typeId: 1) // Pastikan typeId unik untuk setiap model
class OptionHiveModel {
  @HiveField(0)
  String? optionid;

  @HiveField(1)
  String? optionName;

  @HiveField(2)
  int? points;

  @HiveField(3)
  int? flag;

  OptionHiveModel({
    this.optionid,
    this.optionName,
    this.points,
    this.flag,
  });

  Option toEntity() {
    return Option(
      optionid: optionid,
      optionName: optionName,
      points: points,
      flag: flag,
    );
  }
}
