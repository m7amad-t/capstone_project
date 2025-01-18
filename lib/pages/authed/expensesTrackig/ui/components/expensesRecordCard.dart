import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/expensesModel.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/expensesRecords.dart';
import 'package:shop_owner/shared/UI/appDialogs.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ExpensesRecordCard extends StatelessWidget {
  final ExpensesRecordsModel record;
  final ExpensesModel expense;
  const ExpensesRecordCard({
    super.key,
    required this.record,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);

    return SizedBox(
      height: AppSizes.s150,
      child: Card(
        child: InkWell(
             onLongPress: () {
              locator<AppDialogs>().showExpenseRecordDeleteConfiramtion(
                expenseRecord: record,
                expesnes: expense,
              );
            },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppPaddings.p10,
              vertical: AppPaddings.p10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        child: _info(
                          context.translate.cost,
                          record.amount.toStringAsFixed(2),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            record.note ?? "",
                            style: textStyle.displaySmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              getAppDate(record.date),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _info(String lable, String value) {
    return Builder(
      builder: (context) {
        final textStyle = TextTheme.of(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              lable,
              style: textStyle.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style: textStyle.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
