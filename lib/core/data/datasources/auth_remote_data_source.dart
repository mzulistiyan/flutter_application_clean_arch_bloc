import '../../../common/common.dart';
import '../../core.dart';

abstract class AuthRemoteDataSource {
  Future<String> signIn(String nik, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;
  final SecureStorageClient secureStorageClient;

  AuthRemoteDataSourceImpl({required this.dioClient, required this.secureStorageClient});

  @override
  Future<String> signIn(
    String nik,
    String password,
  ) async {
    final response = await dioClient.signIn(
      url: UrlConstant.login,
      data: {
        'nik': nik,
        'password': password,
      },
    );

    if (response.response.statusCode == 200) {
      return response.token ?? '';
    } else {
      throw ServerException();
    }
  }
}
