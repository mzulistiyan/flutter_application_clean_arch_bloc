import 'package:dartz/dartz.dart';

import '../../core.dart';
import '../../../common/common.dart';

class GetListAssessment {
  final AssessmentRepository repository;

  GetListAssessment(this.repository);

  Future<Either<Failure, List<Assessment>>> execute() {
    return repository.getAssesment();
  }
}
