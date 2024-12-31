// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/home/ui/homePage.dart';
import 'package:shop_owner/pages/login/ui/loginPage.dart';
import 'package:shop_owner/router/navigationService.dart';
import 'package:shop_owner/router/routes.dart';
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
          if(state.fullPath == AppRoutes.login){
            // if(context.read<>)
          }
        },
      );
}
