import 'package:dartz/dartz.dart';

import '../../core.dart';
import '../../../common/common.dart';

class PostAssessment {
  final AssessmentRepository repository;

  PostAssessment(this.repository);

  Future<Either<Failure, String>> execute({required BodyReqAssesment bodyReqAssesment}) {
    return repository.postAssessment(bodyReqAssesment: bodyReqAssesment);
  }
}
