import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workmanager/workmanager.dart';
import 'common/common.dart';
import 'core/core.dart';
import 'injection.dart' as di;
import 'presentation/presentation.dart';

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case 'simpleTask':
        await di.init();
        final AssessmentPostBloc assesmentBloc = di.locator<AssessmentPostBloc>();

        //open box
        Box<BodyReqHiveAssesment> assessmentBox = await Hive.openBox<BodyReqHiveAssesment>('AnswerAssessmentLocal');

        //get all data from box as list
        List<BodyReqHiveAssesment> bodyReq = assessmentBox.values.toList();

        debugPrint('Data From Work Manager: ${bodyReq[0].assessmentId ?? ''}');
        // Konversi List<AnswerHive> menjadi List<Answer>
        if (bodyReq.isNotEmpty) {
          for (var i = 0; i < bodyReq.length; i++) {
            BodyReqAssesment bodyReqAssesment = convertToServerModel(bodyReq[i]);
            assesmentBloc.add(
              PostAssessmentAnswer(
                bodyReqAssesment: bodyReqAssesment,
              ),
            );
            bodyReq.removeAt(i);
          }
        }
        break;
      default:
    }

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  SecureStorageClient storageClient = SecureStorageClient.instance;

  bool isLogin = await storageClient.containsKey(SharedPrefKey.accessToken);
  runApp(MyApp(
    isLogin: isLogin,
  ));
}

class MyApp extends StatelessWidget {
  final bool _isLogin;

  const MyApp({
    Key? key,
    bool isLogin = false,
  })  : _isLogin = isLogin,
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<ListAssessmentBloc>()),
        BlocProvider(create: (context) => di.locator<AssessmentDetailBloc>()),
        BlocProvider(create: (context) => di.locator<SignInBloc>()),
        BlocProvider(create: (context) => di.locator<AssessmentPostBloc>()),
        BlocProvider(create: (context) => di.locator<InsertAssessmentLocalBloc>()),
        BlocProvider(create: (context) => di.locator<AssessmentDetailHiveBlocBloc>()),
        BlocProvider(create: (context) => di.locator<InsertDetailAssessmentLocalBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          textTheme: GoogleFonts.getTextTheme('Inter'),
          useMaterial3: true,
        ),
        home: _isLogin ? const ListAssessmentScreen() : const SignInScreen(),
      ),
    );
  }
}

BodyReqAssesment convertToServerModel(BodyReqHiveAssesment hiveModel) {
  List<Answer>? answers = hiveModel.answers
      ?.map((answerHive) => Answer(
            questionId: answerHive.questionId,
            answer: answerHive.answer,
          ))
      .toList();

  return BodyReqAssesment(
    assessmentId: hiveModel.assessmentId,
    answers: answers,
  );
}
