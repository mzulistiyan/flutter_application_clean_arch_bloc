import 'package:dartz/dartz.dart';

import '../../core.dart';
import '../../../common/common.dart';

class InsertAnswerToLocal {
  final AssessmentRepository repository;

  InsertAnswerToLocal(this.repository);

  Future<Either<Failure, String>> execute(BodyReqHiveAssesment bodyAnswer) {
    return repository.insertAnswerAssessmentToLocal(bodyAnswer);
  }
}
