import 'package:flutter/material.dart';
import 'package:shop_owner/shared/UI/appDialogs.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class LanguageListTile extends StatelessWidget {
  const LanguageListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentFlag = context.flag;
    final textStyle = Theme.of(context).textTheme;
    return ListTile(
      onTap: () async {
        locator<AppDialogs>().showChangeLanguage();
      },
      trailing: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppSizes.s4,
          vertical: AppSizes.s2,
        ),
        height: AppSizes.s35,
        width: AppSizes.s45,
        child: Image.asset(
          currentFlag,
          fit: BoxFit.cover,
        ),
      ),
      leading: Text(
        context.translate.language,
        style: textStyle.displayLarge,
      ),
    );
  }
}
