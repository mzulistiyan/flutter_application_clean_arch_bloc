import '../../../common/common.dart';
import '../../core.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> signIn({
    required String nik,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.signIn(
        nik,
        password,
      );
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }
}
