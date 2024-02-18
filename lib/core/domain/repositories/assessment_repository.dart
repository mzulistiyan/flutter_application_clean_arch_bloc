import 'package:dartz/dartz.dart';
import '../../../common/common.dart';
import '../../core.dart';

abstract class AssessmentRepository {
  Future<Either<Failure, List<Assessment>>> getAssesment();
}
