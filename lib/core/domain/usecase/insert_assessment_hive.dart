import 'package:dartz/dartz.dart';

import '../../core.dart';
import '../../../common/common.dart';

class SaveAssessment {
  final AssessmentRepository repository;

  SaveAssessment(this.repository);

  Future<Either<Failure, String>> execute(AssessmentHiveModel assessment) {
    return repository.insertAssessment(assessment);
  }
}
