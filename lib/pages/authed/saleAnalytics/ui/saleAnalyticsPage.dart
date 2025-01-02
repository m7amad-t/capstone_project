import 'package:flutter/material.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class SaleAnalyticPage extends StatefulWidget {
  const SaleAnalyticPage({super.key});

  @override
  State<SaleAnalyticPage> createState() => _SaleAnalyticPageState();
}

class _SaleAnalyticPageState extends State<SaleAnalyticPage> {
  @override
  Widget build(BuildContext context) {
     final _textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate.sale_analytics),
      ),
      body: Container(),
    );
  }
}