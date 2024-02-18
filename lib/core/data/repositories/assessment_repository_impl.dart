import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../core.dart';
import 'package:dartz/dartz.dart';

class AssessmentRepositoryImpl implements AssessmentRepository {
  final AssessmentRemoteDataSource remoteDataSource;

  AssessmentRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Assessment>>> getAssesment() async {
    try {
      final result = await remoteDataSource.getAssessment();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, AssessmentDetail>> getAssessmentDetail(String id) async {
    try {
      final result = await remoteDataSource.getAssessmentDetail(id);
      debugPrint('result: $result');
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }
}
