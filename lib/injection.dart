import 'package:cookie_jar/cookie_jar.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import '../../../core/core.dart';
import 'presentation/presentation.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // SSL pinning
  var logger = Logger();
  Get.put<Logger>(logger); // Memasukkan logger ke dalam container Get

  //CookieJar
  var cookieJar = CookieJar();
  Get.put<CookieJar>(cookieJar);

  final DioClient ioClient = DioClient(
    logger: Get.find<Logger>(), // Memastikan Logger diinject ke DioClient
    cookieJar: CookieJar(),
  );

  final SecureStorageClient secureStorageClient = SecureStorageClient.instance;

  // Assessment external
  Get.put<DioClient>(ioClient);

  // Assessment data source
  Get.put<AssessmentRemoteDataSource>(AssessmentRemoteDataSourceImpl(
    dioClient: Get.find(),
    secureStorageClient: secureStorageClient,
  ));

  //auth data source
  Get.put<AuthRemoteDataSource>(AuthRemoteDataSourceImpl(
    dioClient: Get.find(),
    secureStorageClient: secureStorageClient,
  ));

  // Assessment repository
  Get.put<AssessmentRepository>(AssessmentRepositoryImpl(
    remoteDataSource: Get.find(),
  ));

  // auth repository
  Get.put<AuthRepository>(AuthRepositoryImpl(
    remoteDataSource: Get.find(),
  ));

  // Assessment usecases
  Get.put(GetListAssessment(Get.find()));
  Get.put(GetAssessmentDetail(Get.find()));
  Get.put(PostAssessment(Get.find()));

  // auth usecases
  Get.put(SignIn(Get.find()));

  // bloc
  locator.registerFactory(() => ListAssessmentBloc(locator()));
  locator.registerLazySingleton(() => AssessmentDetailBloc(locator()));
  locator.registerLazySingleton(() => SignInBloc(locator()));
  locator.registerLazySingleton(() => AssessmentPostBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetListAssessment(locator()));
  locator.registerLazySingleton(() => GetAssessmentDetail(locator()));
  locator.registerLazySingleton(() => SignIn(locator()));
  locator.registerLazySingleton(() => PostAssessment(locator()));

  // repository
  locator.registerLazySingleton<AssessmentRepository>(
    () => AssessmentRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<AssessmentRemoteDataSource>(
    () => AssessmentRemoteDataSourceImpl(
      dioClient: Get.find(),
      secureStorageClient: secureStorageClient,
    ),
  );

  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      dioClient: Get.find(),
      secureStorageClient: secureStorageClient,
    ),
  );

  // helper

  // network info

  // external
  locator.registerLazySingleton(() => ioClient);

  //init size config
}
