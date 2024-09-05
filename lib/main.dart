import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'common/common.dart';
import 'injection.dart' as di;
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  //Local initialization
  initializeDateFormatting();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [],
      child: MaterialApp.router(
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routerDelegate: AppRouter.router.routerDelegate,
        title: 'App',
        builder: EasyLoading.init(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.grey,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: ColorConstant.primaryColor,
            secondary: ColorConstant.secondaryColor,
          ),
          fontFamily: 'DM Sans',
          // appBarTheme: AppBarTheme(
          //   foregroundColor: Colors.white,
          //   backgroundColor: Colors.white,
          //   surfaceTintColor: Colors.white,
          // ),
        ),
      ),
    );
  }
}
