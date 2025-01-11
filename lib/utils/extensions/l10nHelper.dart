// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shop_owner/l10n/l10n.dart';
import 'package:shop_owner/shared/assetPaths.dart';

extension CustomLocalization on BuildContext {
  AppLocalizations get translate => AppLocalizations.of(this)!;

  String  get flag {
    String countryCode = Localizations.localeOf(this).toString();
    switch (countryCode) {
      case 'en':
        return AssetPaths.usa;
      case 'ku':
        return AssetPaths.kurd;
      case 'ar':
        return AssetPaths.iraq;
      default:
        return AssetPaths.lang;
    }
  }

  String get languageName => L10n.getTitle(Localizations.localeOf(this).toString());
  

  String get getlangCode => Localizations.localeOf(this).toString();
  
  TextDirection get direction => getlangCode == "en" ? TextDirection.ltr : TextDirection.rtl; 
  
  bool get fromLTR => getlangCode == "en"; 

  Locale get local => Localizations.localeOf(this);
}

extension LocaleHelpers on Locale {
  String get flag{
    switch (toString()) {
      case 'en':
        return AssetPaths.usa;
      case 'ku':
        return AssetPaths.kurd;
      case 'ar':
        return AssetPaths.iraq;
      default:
        return AssetPaths.lang;
    }
  }



  String get languageName => L10n.getTitle(toString());
  
}
