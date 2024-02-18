import 'package:dartz/dartz.dart';
import '../../core.dart';
import '../../../common/common.dart';

class GetAssessmentDetail {
  final AssessmentRepository repository;

  GetAssessmentDetail(this.repository);

  Future<Either<Failure, AssessmentDetail>> execute(String id) {
    return repository.getAssessmentDetail(id);
  }
}
