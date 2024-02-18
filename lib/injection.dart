import 'package:flutter_application_clean_arch/presentation/assessment/bloc/list_assessment_bloc.dart';
import 'package:flutter_application_clean_arch/presentation/presentation.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import '../../../core/core.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // SSL pinning
  var logger = Logger();
  Get.put<Logger>(logger); // Memasukkan logger ke dalam container Get

  final DioClient ioClient = DioClient(
    logger: Get.find<Logger>(), // Memastikan Logger diinject ke DioClient
  );

  // Assessment external
  Get.put<DioClient>(ioClient);

  // Assessment data source
  Get.put<AssessmentRemoteDataSource>(AssessmentRemoteDataSourceImpl(
    dioClient: Get.find(),
  ));

  // Assessment repository
  Get.put<AssessmentRepository>(AssessmentRepositoryImpl(
    remoteDataSource: Get.find(),
  ));

  // tvseries usecases
  Get.put(GetListAssessment(Get.find()));
  Get.put(GetAssessmentDetail(Get.find()));

  // bloc
  locator.registerFactory(() => ListAssessmentBloc(locator()));
  locator.registerLazySingleton(() => AssessmentDetailBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetListAssessment(locator()));
  locator.registerLazySingleton(() => GetAssessmentDetail(locator()));

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

  //init size config
}
