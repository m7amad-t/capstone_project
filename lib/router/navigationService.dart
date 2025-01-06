import 'package:flutter/material.dart';
import 'package:shop_owner/shared/uiComponents.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/utils/di/contextDI.dart';

class NavigationService {
  // navigator service key
  final GlobalKey<NavigatorState> _navigatorState = GlobalKey<NavigatorState>(
    debugLabel: 'root navigator',
  );


  GlobalKey<NavigatorState> get key => _navigatorState;

  // method to navigate to a new route
  Future<void>? naviagteTo(String path) {
    return _navigatorState.currentState?.pushNamed(path);
  }

  // method to pop curent page
  void pop() {
    if (_navigatorState.currentState?.canPop() ?? false) {
      return _navigatorState.currentState?.pop();
    }
  }

  // method to navigate to a new route
  Future<void>? naviagteWithArgTo(String path, Map<String, dynamic> args) {
    return _navigatorState.currentState?.pushNamed(path, arguments: args);
  }

  // method to navigate back to root
  void naviagteHome(String path) {
    return _navigatorState.currentState?.popUntil((route) => route.isFirst);
  }

  // method to show dialogs 
  void showDialog(BuildContext context, Widget child) {
   
  }
}
