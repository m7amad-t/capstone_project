import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class _KurdishMaterialLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const _KurdishMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ku';

  @override
  Future<WidgetsLocalizations> load(Locale locale) async {
    return SynchronousFuture<WidgetsLocalizations>(
      KurdishWidgetLocalizations(),
    );
  }

  @override
  bool shouldReload(_KurdishMaterialLocalizationsDelegate old) => false;
}

class KurdishWidgetLocalizations extends WidgetsLocalizations {
  static const LocalizationsDelegate<WidgetsLocalizations> delegate =
      _KurdishMaterialLocalizationsDelegate();

  @override
  TextDirection get textDirection => TextDirection.rtl;

  @override
  String get reorderItemDown => 'ڕیزکردنی ئایتم بۆ خوارەوە';

  @override
  String get reorderItemLeft => 'ڕیزکردنی ئایتم بۆ لای چەپ';

  @override
  String get reorderItemRight => 'ڕیزکردنی ئایتم بۆ لای ڕاست';

  @override
  String get reorderItemToEnd => 'ڕیزکردنی ئایتم بۆ کۆتایی';

  @override
  String get reorderItemToStart => 'ڕیزکردنی ئایتم بۆ دەستپێک';

  @override
  String get reorderItemUp => 'ڕیزکردنی ئایتم بۆ سەرەوە';
}
