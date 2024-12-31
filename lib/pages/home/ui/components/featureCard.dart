// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shop_owner/pages/home/logic/models/featureModel.dart';

class FeatureCard extends StatelessWidget {
  final AppFeature feature;
  const FeatureCard({super.key, required this.feature});

  void _tapCallBack() {
    // todo : navigate to the feature page..
  }

  @override
  Widget build(BuildContext context) {
    final _textStyle = Theme.of(context).textTheme;
    return Card(
      child: InkWell(
        onTap: _tapCallBack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex : 5, 
              child: Image.asset(
                feature.imagePath,
                fit: BoxFit.cover,

                // width: ,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                feature.name,
                style: _textStyle.displayMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
