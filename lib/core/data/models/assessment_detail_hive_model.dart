import 'package:hive/hive.dart';

import '../../core.dart';

part 'assessment_detail_hive_model.g.dart';

@HiveType(typeId: 3)
class AssessmentDetailResponseHive {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final List<QuestionHiveModel>? question;

  const AssessmentDetailResponseHive({
    this.id,
    this.name,
    this.question,
  });

  AssessmentDetail toEntity() {
    return AssessmentDetail(
      id: id,
      name: name,
      question: question!.map((questions) => questions.toEntity()).toList(),
    );
  }
}
