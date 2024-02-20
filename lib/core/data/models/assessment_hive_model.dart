import 'package:flutter_application_clean_arch/core/core.dart';
import 'package:hive/hive.dart';

part 'assessment_hive_model.g.dart';

@HiveType(typeId: 0)
class AssessmentHiveModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  DateTime? assessmentDate;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? type;

  @HiveField(5)
  DateTime? createdAt;

  @HiveField(6)
  DateTime? lastDownloaded;

  AssessmentHiveModel({
    this.id,
    this.name,
    this.assessmentDate,
    this.description,
    this.type,
    this.createdAt,
    this.lastDownloaded,
  });

  Assessment toEntity() {
    return Assessment(
      id: id,
      name: name,
      assessmentDate: assessmentDate,
      description: description,
      type: type,
      createdAt: createdAt,
      downloadedAt: lastDownloaded,
    );
  }
}
