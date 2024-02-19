import 'package:dartz/dartz.dart';

import '../../core.dart';
import '../../../common/common.dart';

class SignIn {
  final AuthRepository repository;

  SignIn(this.repository);

  Future<Either<Failure, String>> execute({required String nik, required String password}) {
    return repository.signIn(nik: nik, password: password);
  }
}
