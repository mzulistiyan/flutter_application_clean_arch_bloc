import 'package:hive/hive.dart';

import '../../core.dart';

part 'assessment_question_hive_model.g.dart';

@HiveType(typeId: 2)
class QuestionHiveModel {
  @HiveField(0)
  String? questionid;
  @HiveField(1)
  String? section;
  @HiveField(2)
  String? number;
  @HiveField(3)
  String? type;
  @HiveField(4)
  String? questionName;
  @HiveField(5)
  bool? scoring;
  @HiveField(6)
  List<OptionHiveModel>? options;

  QuestionHiveModel({
    this.questionid,
    this.section,
    this.number,
    this.type,
    this.questionName,
    this.scoring,
    this.options,
  });

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
