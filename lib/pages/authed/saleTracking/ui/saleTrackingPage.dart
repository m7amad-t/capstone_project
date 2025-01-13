import 'package:flutter/material.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class SaleTrackingPage extends StatefulWidget {
  const SaleTrackingPage({super.key});

  @override
  State<SaleTrackingPage> createState() => _SaleTrackingPageState();
}

class _SaleTrackingPageState extends State<SaleTrackingPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate.sale),
      ),
      body: Container(),
    );
  }
}
