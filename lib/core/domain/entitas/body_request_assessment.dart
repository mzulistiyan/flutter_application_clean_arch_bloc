import 'package:equatable/equatable.dart';

class BodyReqAssesment extends Equatable {
  String? assessmentId;
  List<Answer>? answers;

  BodyReqAssesment({
    this.assessmentId,
    this.answers,
  });

  factory BodyReqAssesment.fromJson(Map<String, dynamic> json) => BodyReqAssesment(
        assessmentId: json["assessment_id"],
        answers: json["answers"] == null ? [] : List<Answer>.from(json["answers"]!.map((x) => Answer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "assessment_id": assessmentId,
        "answers": answers == null ? [] : List<dynamic>.from(answers!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [assessmentId, answers];
}

class Answer extends Equatable {
  String? questionId;
  String? answer;

  Answer({
    this.questionId,
    this.answer,
  });
  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        questionId: json["question_id"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "answer": answer,
      };
  @override
  List<Object?> get props => [questionId, answer];
}
