// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/assetPaths.dart';
import 'package:shop_owner/shared/constants.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ProductManagementPage extends StatelessWidget {
  const ProductManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme _textStyle = Theme.of(context).textTheme;
    
    double maxGridItemWidth = AppConstants.gridCardPrefiredWidth ; 
    // screen width 
    double screenWidth = MediaQuery.of(context).size.width ;

    // caluculate proper number of items in one row 
    int itemsPerRow = (screenWidth / maxGridItemWidth).floor();

    late final List<Map<String, dynamic>> _fatures = [
      // products
      {
        'name': context.translate.product_management,
        "path": '${AppRoutes.productManagement}/${AppRoutes.product}',
        'icon': Image.asset(AssetPaths.product),
      },

      // categories
      {
        'name': context.translate.category_management,
        "path": '${AppRoutes.productManagement}/${AppRoutes.category}',
        'icon': Image.asset(AssetPaths.category)
      },
      // categories
      {
        'name': 'product return',
        "path": '${AppRoutes.productManagement}/${AppRoutes.returnProduct}',
        'icon': Image.asset(AssetPaths.category)
      },
    ];

    return Scaffold(

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:  AppSizes.s10),
        child: Column(
          children: [
            GridView.builder(
              padding: EdgeInsets.symmetric( vertical: AppSizes.s20 ),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: itemsPerRow,
                childAspectRatio: 1,
                crossAxisSpacing: AppSizes.s10,
                mainAxisSpacing: AppSizes.s10,
              ),
              itemCount: _fatures.length,
              itemBuilder: (context, index) =>
                  _FeatureCard(_fatures[index], _textStyle, context,),
            ),
          ],
        ),
      ),
    );
  }

  void _cardTapCallBack(BuildContext context, String path) {
    GoRouter.of(context).push(
      path,
    );
  }

  Widget _FeatureCard(Map<String, dynamic> feature, TextTheme _textStyle,
      BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          return _cardTapCallBack(
            context,
            feature['path'],
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: feature['icon'],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  feature['name'],
                  style: _textStyle.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
