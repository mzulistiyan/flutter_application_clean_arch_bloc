import 'package:cookie_jar/cookie_jar.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import '../../../core/core.dart';
import 'presentation/presentation.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // SSL pinning
  var logger = Logger();
  Get.put<Logger>(logger); // Memasukkan logger ke dalam container Get

  //init hive
  await Hive.initFlutter();
  // Hive.registerAdapter(CatModelAdapter());
  //register adapter
  Hive.registerAdapter(AssessmentHiveModelAdapter());
  Hive.openBox<AssessmentHiveModel>('assessments');
  Hive.registerAdapter(QuestionHiveModelAdapter());
  Hive.openBox<QuestionHiveModel>('questions');
  Hive.registerAdapter(OptionHiveModelAdapter());
  Hive.openBox<OptionHiveModel>('options');
  Hive.registerAdapter(AssessmentDetailResponseHiveAdapter());
  Hive.openBox<AssessmentDetailResponseHive>('assessmentDetail');

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

  //assessment data source local
  Get.put<AssessmentLocalDataSource>(AssessmentLocalDataSourceImpl());

  //auth data source
  Get.put<AuthRemoteDataSource>(AuthRemoteDataSourceImpl(
    dioClient: Get.find(),
    secureStorageClient: secureStorageClient,
  ));

  // Assessment repository
  Get.put<AssessmentRepository>(AssessmentRepositoryImpl(
    remoteDataSource: Get.find(),
    localDataSource: Get.find(),
  ));

  // auth repository
  Get.put<AuthRepository>(AuthRepositoryImpl(
    remoteDataSource: Get.find(),
  ));

  // Assessment usecases
  Get.put(GetListAssessment(Get.find()));
  Get.put(GetAssessmentDetail(Get.find()));
  Get.put(PostAssessment(Get.find()));
  Get.put(SaveAssessment(Get.find()));
  Get.put(GetAssessmentCached(Get.find()));
  Get.put(SaveAssessmentDetail(Get.find()));
  Get.put(GetAssessmentDetailCached(Get.find()));

  // auth usecases
  Get.put(SignIn(Get.find()));

  // bloc
  locator.registerFactory(() => ListAssessmentBloc(locator()));
  locator.registerLazySingleton(() => AssessmentDetailBloc(locator()));
  locator.registerLazySingleton(() => SignInBloc(locator()));
  locator.registerLazySingleton(() => AssessmentPostBloc(locator()));
  locator.registerLazySingleton(() => InsertAssessmentLocalBloc(locator()));
  locator.registerLazySingleton(() => AssessmentDetailHiveBlocBloc(locator()));
  locator.registerLazySingleton(() => InsertDetailAssessmentLocalBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetListAssessment(locator()));
  locator.registerLazySingleton(() => GetAssessmentDetail(locator()));
  locator.registerLazySingleton(() => SignIn(locator()));
  locator.registerLazySingleton(() => PostAssessment(locator()));
  locator.registerLazySingleton(() => SaveAssessment(locator()));
  locator.registerLazySingleton(() => GetAssessmentCached(locator()));
  locator.registerLazySingleton(() => SaveAssessmentDetail(locator()));
  locator.registerLazySingleton(() => GetAssessmentDetailCached(locator()));

  // repository
  locator.registerLazySingleton<AssessmentRepository>(
    () => AssessmentRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
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

  //assessment data source local
  locator.registerLazySingleton<AssessmentLocalDataSource>(
    () => AssessmentLocalDataSourceImpl(),
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
