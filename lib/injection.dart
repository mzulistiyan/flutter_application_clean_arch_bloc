import 'package:flutter_application_clean_arch/presentation/assessment/bloc/list_assessment_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import '../../../core/core.dart';

final locator = GetIt.instance;

/// Submission 1108243 Fix
/// Make the init asynchronous
Future<void> init() async {
  // SSL pinning
  var logger = Logger();
  Get.put<Logger>(logger); // Memasukkan logger ke dalam container Get

  final DioClient ioClient = DioClient(
    logger: Get.find<Logger>(), // Memastikan Logger diinject ke DioClient
  );

  // tv series external
  Get.put<DioClient>(ioClient);

  // tv series data source
  Get.put<AssessmentRemoteDataSource>(AssessmentRemoteDataSourceImpl(
    dioClient: Get.find(),
  ));

  // tv series repository
  Get.put<AssessmentRepository>(AssessmentRepositoryImpl(
    remoteDataSource: Get.find(),
  ));

  // tvseries usecases
  Get.put(GetListAssessment(Get.find()));

  // bloc
  locator.registerFactory(() => ListAssessmentBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetListAssessment(locator()));

  // repository
  locator.registerLazySingleton<AssessmentRepository>(
    () => AssessmentRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<AssessmentRemoteDataSource>(() => AssessmentRemoteDataSourceImpl(dioClient: Get.find()));

  // helper

  // network info

  // external
  locator.registerLazySingleton(() => ioClient);
}
