import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'common/common.dart';
import 'core/core.dart';
import 'injection.dart' as di;
import 'presentation/presentation.dart';

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
