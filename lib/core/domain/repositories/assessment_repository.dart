import 'package:dartz/dartz.dart';
import '../../../common/common.dart';
import '../../core.dart';

abstract class AssessmentRepository {
  Future<Either<Failure, List<Assessment>>> getAssesment();
  Future<Either<Failure, AssessmentDetail>> getAssessmentDetail(String id);
  Future<Either<Failure, String>> postAssessment({
    required BodyReqAssesment bodyReqAssesment,
  });
  Future<Either<Failure, String>> insertAssessment(AssessmentHiveModel assessment);
  Future<Either<Failure, List<AssessmentHiveModel>>> getAssessmentCached();
  Future<Either<Failure, AssessmentDetailResponseHive>> getAssessmentDetailCached(String id);
  Future<Either<Failure, String>> insertAssessmentDail(AssessmentDetailResponseHive assessmentDetail);
}
