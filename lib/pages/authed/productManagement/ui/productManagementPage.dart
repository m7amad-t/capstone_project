// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/assetPaths.dart';
import 'package:shop_owner/shared/constants.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ProductManagementPage extends StatelessWidget {
  const ProductManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme _textStyle = Theme.of(context).textTheme;

    double maxGridItemWidth = AppConstants.gridCardPrefiredWidth;
    // screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // caluculate proper number of items in one row
    int itemsPerRow = (screenWidth / maxGridItemWidth).floor();

    late final List<Map<String, dynamic>> _fatures = [
      // products
      {
        'name': context.translate.product_management,
        "path": '${AppRoutes.productManagement}/${AppRoutes.product}',
        'icon': Image.asset(AssetPaths.productManagement),
      },

      // categories
      {
        'name': context.translate.category_management,
        "path": '${AppRoutes.productManagement}/${AppRoutes.category}',
        'icon': Image.asset(AssetPaths.categoryManagement)
      },
      // Buy Products
      {
        'name': 'Buy products',
        "path": '${AppRoutes.productManagement}/${AppRoutes.buyProducts}',
        'icon': Image.asset(AssetPaths.buyingProducts)
      },
      // buying history
      {
        'name': 'Boughted history',
        "path": '${AppRoutes.productManagement}/${AppRoutes.boughtedProducts}',
        'icon': Image.asset(AssetPaths.buoughtedProducts)
      },
      // return product..
      {
        'name': 'Returned products',
        "path": '${AppRoutes.productManagement}/${AppRoutes.returnedProduct}',
        'icon': Image.asset(AssetPaths.returnedProducts)
      },
      {
        'name': 'Damaged Products',
        "path": '${AppRoutes.productManagement}/${AppRoutes.damagedProducts}',
        'icon': Image.asset(AssetPaths.damagedProducts)
      },
      // return product..
      {
        'name': 'Expired Products',
        "path": '${AppRoutes.productManagement}/${AppRoutes.expiredProducts}',
        'icon': Image.asset(AssetPaths.expiredProducts)
      },
      // return product..
      
    ];

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.s10),
        child: Column(
          children: [
            GridView.builder(
              padding: EdgeInsets.symmetric(vertical: AppSizes.s30),
              shrinkWrap: true,
              physics: const  NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: itemsPerRow,
                childAspectRatio: 1,
                crossAxisSpacing: AppSizes.s10,
                mainAxisSpacing: AppSizes.s10,
              ),
              itemCount: _fatures.length,
              itemBuilder: (context, index) => _FeatureCard(
                _fatures[index],
                _textStyle,
                context,
              ),
            ),

            gap(height: AppSizes.s150), 
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
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10),
                alignment: Alignment.center,
                child: Text(
                  feature['name'],
                  textAlign: TextAlign.center,
                  style: _textStyle.bodyMedium,
                ),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: AppPaddings.p6 , vertical: AppPaddings.p10,),
      ),
    );
  }
}
