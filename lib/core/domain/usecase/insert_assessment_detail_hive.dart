import 'package:dartz/dartz.dart';

import '../../core.dart';
import '../../../common/common.dart';

class SaveAssessmentDetail {
  final AssessmentRepository repository;

  SaveAssessmentDetail(this.repository);

  Future<Either<Failure, String>> execute(
    AssessmentDetailResponseHive assessmentDetail,
  ) {
    return repository.insertAssessmentDail(assessmentDetail);
  }
}
