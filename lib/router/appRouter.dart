// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/home/ui/homePage.dart';
import 'package:shop_owner/pages/notAuthed/login/ui/loginPage.dart';
import 'package:shop_owner/router/navigationService.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/utils/auth/userModel.dart';
import 'package:shop_owner/utils/di/contextDI.dart';

class AppRouter {
  final GlobalKey<NavigatorState> _navigatorKey =
      locator<NavigationService>().key;

  GoRouter get router => GoRouter(
        debugLogDiagnostics: true,
        navigatorKey: _navigatorKey,
        initialLocation: AppRoutes.home,
        routes: <RouteBase>[
          // home route
          GoRoute(
            path: AppRoutes.home,
            parentNavigatorKey: _navigatorKey,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomePage(),
            ),
          ),

          // login route
          GoRoute(
            path: AppRoutes.login,
            parentNavigatorKey: _navigatorKey,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: LoginPage(),
            ),
          ),
        ],
        redirect: (context, state) {
          // check if user is logged in
          final bool isUserInjected = locator.isRegistered<User>();

          if (isUserInjected) {
            return AppRoutes.home;
          } else {
            return AppRoutes.login;
          }
        },
      );
}
