import 'package:flutter/material.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class NoDataFoundCase extends StatelessWidget {
  final Widget changeDateButton ; 
  const NoDataFoundCase({super.key , required this.changeDateButton});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);
        return Column(
          children: [
            gap(height: AppPaddings.p30),
            changeDateButton, 
            gap(height: AppPaddings.p30),
            Text(
              context.translate.no_data_found,
              style: textStyle.displayMedium,
            ),
          ],
        );
  }
}