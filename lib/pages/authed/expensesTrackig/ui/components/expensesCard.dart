import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/expensesModel.dart';
import 'package:shop_owner/router/extraTemplates/expensesExtra.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/UI/appDialogs.dart';
import 'package:shop_owner/utils/di/contextDI.dart';

class ExpensesCard extends StatelessWidget {
  final ExpensesModel model;
  const ExpensesCard({super.key, required this.model});

  _onTap(BuildContext context) {
    GoRouter.of(context).go("${AppRoutes.expensesTracking}/${AppRoutes.expensRecordHistory}" , extra: ExpensExtra(model: model).extra, );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);
    // scale the card based on its palce in the parent
    return Card(
      child: InkWell(
        onLongPress: (){
          locator<AppDialogs>().showExpenseTypeDeleteConfiramtion(expesnes: model); 
        },
        onTap: (){
          _onTap(context);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              model.name,
              style: textStyle.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}
