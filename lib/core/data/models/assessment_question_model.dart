// To parse this JSON data, do
//
//     final questionModel = questionModelFromJson(jsonString);

import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../../core.dart';

QuestionModel questionModelFromJson(String str) => QuestionModel.fromJson(json.decode(str));

String questionModelToJson(QuestionModel data) => json.encode(data.toJson());

class QuestionModel extends Equatable {
  String? questionid;
  String? section;
  String? number;
  String? type;
  String? questionName;
  bool? scoring;
  List<OptionModel>? options;

  QuestionModel({
    this.questionid,
    this.section,
    this.number,
    this.type,
    this.questionName,
    this.scoring,
    this.options,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        questionid: json["questionid"],
        section: json["section"],
        number: json["number"],
        type: json["type"],
        questionName: json["question_name"],
        scoring: json["scoring"],
        options: json["options"] == null ? [] : List<OptionModel>.from(json["options"]!.map((x) => OptionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "questionid": questionid,
        "section": section,
        "number": number,
        "type": type,
        "question_name": questionName,
        "scoring": scoring,
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [questionid, section, number, type, questionName, scoring, options];

  Question toEntity() {
    return Question(
      questionid: questionid,
      section: section,
      number: number,
      type: type,
      questionName: questionName,
      scoring: scoring,
      options: options!.map((option) => option.toEntity()).toList(),
    );
  }
}
