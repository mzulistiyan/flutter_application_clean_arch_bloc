// To parse this JSON data, do
//
//     final assessment = assessmentFromJson(jsonString);

import 'dart:convert';
import '../../core.dart';
import 'package:equatable/equatable.dart';

AssessmentModel assessmentModelFromJson(String str) => AssessmentModel.fromJson(json.decode(str));

String assessmentModelToJson(AssessmentModel data) => json.encode(data.toJson());

class AssessmentModel extends Equatable {
  String? id;
  String? name;
  DateTime? assessmentDate;
  String? description;
  String? type;
  DateTime? createdAt;
  DateTime? downloadedAt;

  AssessmentModel({
    this.id,
    this.name,
    this.assessmentDate,
    this.description,
    this.type,
    this.createdAt,
    this.downloadedAt,
  });

  factory AssessmentModel.fromJson(Map<String, dynamic> json) => AssessmentModel(
        id: json["id"],
        name: json["name"],
        assessmentDate: json["assessment_date"] == null ? null : DateTime.parse(json["assessment_date"]),
        description: json["description"],
        type: json["type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        downloadedAt: json["downloaded_at"] == null ? null : DateTime.parse(json["downloaded_at"]),
      );

  Assessment toEntity() {
    return Assessment(
      id: id,
      name: name,
      assessmentDate: assessmentDate,
      description: description,
      type: type,
      createdAt: createdAt,
      downloadedAt: downloadedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "assessment_date": assessmentDate?.toIso8601String(),
        "description": description,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "downloaded_at": downloadedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [id, name, assessmentDate, description, type, createdAt, downloadedAt];
}
