import 'package:flutter/material.dart';
import 'package:shop_owner/shared/uiComponents.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/utils/di/contextDI.dart';

class NavigationService {
  // navigator service key
  final GlobalKey<NavigatorState> _navigatorState = GlobalKey<NavigatorState>(
    debugLabel: 'navigaton service',
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

  showLoadingDialog(String text) async {
    showDialog(
      context: _navigatorState.currentState!.context,
      barrierDismissible:
          false, // Prevents dialog from being dismissed by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Card(
            elevation: 1,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: locator<DynamicSizes>().p50,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const RepaintBoundary(
                    child: CircularProgressIndicator(),
                  ),
                  gap(height: 10),
                  Text(
                    text,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
