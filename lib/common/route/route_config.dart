import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/presentation.dart';
import '../common.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  // static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: RoutePath.splash,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routerNeglect: true,
    routes: [
      GoRoute(
        path: RoutePath.splash,
        name: RouteName.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
    ],
  );

  static GoRouter get router => _router;
}
