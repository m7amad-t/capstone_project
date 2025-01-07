import 'package:flutter/material.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';

class ProductListTopShadow extends StatelessWidget {
  const ProductListTopShadow({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
            ],
          ),
        ),
        child: Container(
          height: AppSizes.s50,
        ),
      ),
    );
  }
}
