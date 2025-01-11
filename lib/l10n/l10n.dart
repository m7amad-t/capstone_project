import 'package:flutter/material.dart';
import 'package:shop_owner/shared/assetPaths.dart';

class L10n {
  static final all = <Locale>[
    const Locale('ku'),
    const Locale('en'),
    const Locale('ar')
  ];

  static String getTitle(String code) {
    switch (code) {
      case 'ar':
        return 'العربية';
      case 'ku':
        return 'کوردی';
      case 'en':
      default:
        return 'English';
    }
  }




  static String getFlag(String code) {
    switch (code) {
      case 'ar':
        return AssetPaths.iraq;
      case 'ku':
        return AssetPaths.kurd;
      case 'en':
      default:
        return AssetPaths.usa;
    }
  }
}
