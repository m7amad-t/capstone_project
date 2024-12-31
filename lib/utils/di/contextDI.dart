
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_owner/router/navigationService.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/utils/auth/authService.dart';

final locator = GetIt.instance;

void setUpLocator(BuildContext context) {
  // register daynamic size class
  if (locator.isRegistered<DynamicSizes>()) {
    return;
  } else {
    locator.registerSingleton(DynamicSizes(context: context));
  }

  // register navigation service class
  if (locator.isRegistered<NavigationService>()) {
    return;
  } else {
    locator.registerSingleton<NavigationService>(NavigationService());
  }



  // register auth service class incase error try 3 times 
  int count = 0;
  for (; count <= 2; count++) {
    try {
      // register navigation service class
      if (locator.isRegistered<AuthService>()) {
        return;
      } else {
        locator.registerSingleton<AuthService>(AuthService());
        return ; 
      }
    } catch (e) {
      print('Error in setting up locator: $e');
    }
  }

  //
}
