import 'dart:convert';

import 'package:equatable/equatable.dart';
import '../../core.dart';

AssessmentDetailResponse assessmentDetailResponseFromJson(String str) => AssessmentDetailResponse.fromJson(json.decode(str));

String assessmentDetailResponseToJson(AssessmentDetailResponse data) => json.encode(data.toJson());

class AssessmentDetailResponse extends Equatable {
  final String? id;
  final String? name;
  final List<QuestionModel>? question;

  const AssessmentDetailResponse({
    this.id,
    this.name,
    this.question,
  });

  factory AssessmentDetailResponse.fromJson(Map<String, dynamic> json) => AssessmentDetailResponse(
        id: json["id"],
        name: json["name"],
        question: json["question"] == null ? [] : List<QuestionModel>.from(json["question"].map((x) => QuestionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "question": question == null ? [] : List<dynamic>.from(question!.map((x) => x.toJson())),
      };

  AssessmentDetail toEntity() {
    return AssessmentDetail(
      id: id,
      name: name,
      question: question!.map((questions) => questions.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [id, name, question];
}
