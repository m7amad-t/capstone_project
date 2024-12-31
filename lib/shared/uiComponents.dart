// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, unused_element, file_names

import 'package:flutter/material.dart';
import 'package:shop_owner/shared/uiHelper.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

Widget gap({double width = 0.0, double height = 0.0}) {
  return SizedBox(
    width: width,
    height: height,
  );
}

class _LanguageListTile extends StatefulWidget {
  const _LanguageListTile({super.key});

  @override
  State<_LanguageListTile> createState() => _LanguageListTileState();
}

class _LanguageListTileState extends State<_LanguageListTile> {
  late String current;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    current = Localizations.localeOf(context).toString();
    final String currentLanguage = context.languageName;
    final String currentCode = context.local.toString();
    final String currentFlag = context.flag;
    final _textStyle = Theme.of(context).textTheme;
    return ListTile(
      onTap:()async{
       await showChangeLanguage(context); 
      },
      trailing: Container(
        margin: EdgeInsets.symmetric(
            horizontal: AppSizes.s4, vertical: AppSizes.s2),
        height: AppSizes.s35,
        width: AppSizes.s45,

        child: Image.asset(currentFlag , fit: BoxFit.cover,),
      ),
      leading: Text(
        context.translate.language,
        style: _textStyle.displayLarge,
      ),
      );
  }
}

Widget changeLanguageTile() {
  return const _LanguageListTile();
}
