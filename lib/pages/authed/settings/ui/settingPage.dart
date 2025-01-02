import 'package:flutter/material.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
     final _textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate.save),
      ),
      body: Container(),
    );
  }
}