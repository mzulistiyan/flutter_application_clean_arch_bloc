import '../../../common/common.dart';
import '../../core.dart';
import 'package:dartz/dartz.dart';

class AssessmentRepositoryImpl implements AssessmentRepository {
  final AssessmentRemoteDataSource remoteDataSource;
  final AssessmentLocalDataSource localDataSource;

  AssessmentRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Assessment>>> getAssesment() async {
    try {
      // final result = await remoteDataSource.getAssessment();
      // return Right(result.map((model) => model.toEntity()).toList());

      final result = await remoteDataSource.getAssessment();
      final cachedAssessments = await localDataSource.getAssessmentCached(); // Ambil semua data cached

      final assessments = result.map((model) {
        final entity = model.toEntity();
        // Cari entitas yang sama di cache
        final cached = cachedAssessments.firstWhere(
          (cachedModel) => cachedModel.id == entity.id,
          orElse: () => AssessmentHiveModel(),
        );
        // Jika ditemukan, gunakan downloadAt dari cache
        if (cached != null) {
          entity.downloadedAt = cached.lastDownloaded;
        }
        return entity;
      }).toList();

      return Right(assessments);
    } catch (e) {
      try {
        // Jika gagal karena ServerException, coba ambil data dari cache
        final cachedResult = await localDataSource.getAssessmentCached();
        // Konversi hasil dari Hive model ke entity yang diinginkan
        final entityList = cachedResult.map((hiveModel) => hiveModel.toEntity()).toList();

        return Right(entityList);
      } catch (e) {
        // Jika gagal mengambil data dari cache, return ServerFailure
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, AssessmentDetail>> getAssessmentDetail(String id) async {
    try {
      final result = await remoteDataSource.getAssessmentDetail(id);
      return Right(result.toEntity());
    } catch (e) {
      try {
        // Jika gagal karena ServerException, coba ambil data dari cache
        final cachedResult = await localDataSource.getAssessmentDetailCached(id);
        // Konversi hasil dari Hive model ke entity yang diinginkan
        final entityList = cachedResult.toEntity();

        return Right(entityList);
      } catch (e) {
        // Jika gagal mengambil data dari cache, return ServerFailure
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, String>> postAssessment({
    required BodyReqAssesment bodyReqAssesment,
  }) async {
    try {
      final result = await remoteDataSource.postAssessment(
        bodyReqAssesment: bodyReqAssesment,
      );
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, String>> insertAssessment(AssessmentHiveModel assessment) async {
    try {
      final result = await localDataSource.insertAssessment(assessment);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<AssessmentHiveModel>>> getAssessmentCached() async {
    try {
      final result = await localDataSource.getAssessmentCached();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, AssessmentDetailResponseHive>> getAssessmentDetailCached(String id) async {
    try {
      final result = await localDataSource.getAssessmentDetailCached(id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, String>> insertAssessmentDail(AssessmentDetailResponseHive assessmentDetail) async {
    try {
      final result = await localDataSource.insertAssessmentDail(assessmentDetail);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }
}
