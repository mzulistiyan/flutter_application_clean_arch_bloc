import 'package:dartz/dartz.dart';

import '../../core.dart';
import '../../../common/common.dart';

class GetAssessmentCached {
  final AssessmentRepository repository;

  GetAssessmentCached(this.repository);

  Future<Either<Failure, List<AssessmentHiveModel>>> execute() {
    return repository.getAssessmentCached();
  }
}
