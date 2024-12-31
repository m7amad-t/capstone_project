// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/home/logic/models/featureModel.dart';
import 'package:shop_owner/pages/home/ui/components/featureCard.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/assetPaths.dart';
import 'package:shop_owner/shared/drawer.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AppFeature> _features = [
      // product management
      AppSection(
        name: context.translate.product_management,
        imagePath: AssetPaths.productManagement,
        path: AppRoutes.productManagement,
      ),
      // sale tracking
      AppSection(
        name: context.translate.sale,
        imagePath: AssetPaths.saleTracking,
        path: AppRoutes.saleTracking,
      ),
      // expenses tracking
      AppSection(
        name: context.translate.expenses_tracking,
        imagePath: AssetPaths.expensesTracking,
        path: AppRoutes.expensesTracking,
      ),
      // sale analytics
      AppSection(
        name: context.translate.sale_analytics,
        imagePath: AssetPaths.saleAnalytics,
        path: AppRoutes.saleAnalytics,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate.home_screen),
        centerTitle: true,
      ),
      drawer: appDrawer(context),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.p10,
          vertical: AppPaddings.p20,
        ),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: AppSizes.s10,
            mainAxisSpacing: AppSizes.s10,
            childAspectRatio: 1,
            crossAxisCount: 2,
          ),
          itemCount: _features.length,
          itemBuilder: (context, index) => FeatureCard(
            feature: _features[index],
          ),
        ),
      ),
    );
  }
}
