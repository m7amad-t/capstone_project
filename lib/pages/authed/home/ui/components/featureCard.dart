// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/home/logic/models/featureModel.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/router/routes.dart'; 
class FeatureCard extends StatelessWidget {
  final AppFeature feature;
  const FeatureCard({super.key, required this.feature});

  void _tapCallBack(context) {
    GoRouter.of(context).push(feature.path);  
  }

  @override
  Widget build(BuildContext context) {
    final _textStyle = Theme.of(context).textTheme;
    return Card(
      child: InkWell(
        onTap: (){
          _tapCallBack(context); 
        },
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
