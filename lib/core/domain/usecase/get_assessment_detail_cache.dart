import 'package:dartz/dartz.dart';

import '../../core.dart';
import '../../../common/common.dart';

class GetAssessmentDetailCached {
  final AssessmentRepository repository;

  GetAssessmentDetailCached(this.repository);

  Future<Either<Failure, AssessmentDetailResponseHive>> execute(String id) {
    return repository.getAssessmentDetailCached(id);
  }
}
