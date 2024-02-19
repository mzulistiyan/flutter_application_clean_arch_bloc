import 'package:dartz/dartz.dart';
import '../../../common/common.dart';
import '../../core.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> signIn({
    required String nik,
    required String password,
  });
}
