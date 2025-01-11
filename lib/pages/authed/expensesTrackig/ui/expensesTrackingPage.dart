import 'package:flutter/material.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ExpensesTracking extends StatefulWidget {
  const ExpensesTracking({super.key});

  @override
  State<ExpensesTracking> createState() => _ExpensesTrackingState();
}

class _ExpensesTrackingState extends State<ExpensesTracking> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate.expenses_tracking),
      ),
      body: Container(),
    );
  }
}