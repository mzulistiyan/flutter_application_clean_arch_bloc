import 'package:flutter_application_clean_arch/core/core.dart';
import 'package:hive/hive.dart';

part 'body_request_hive_assessment.g.dart';

@HiveType(typeId: 4)
class BodyReqHiveAssesment {
  @HiveField(0)
  String? assessmentId;
  @HiveField(1)
  List<AnswerHive>? answers;

  BodyReqHiveAssesment({
    this.assessmentId,
    this.answers,
  });
}

@HiveType(typeId: 5)
class AnswerHive {
  @HiveField(0)
  String? questionId;
  @HiveField(1)
  String? answer;

  AnswerHive({
    this.questionId,
    this.answer,
  });
}
