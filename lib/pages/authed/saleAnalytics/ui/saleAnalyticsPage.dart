import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/shared/assetPaths.dart';
import 'package:shop_owner/shared/constants.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class SaleAnalyticPage extends StatelessWidget {
  const SaleAnalyticPage({super.key});

  @override
  Widget build(BuildContext context) {
    late final List<Map<String, dynamic>> _fatures = [
      // products
      {
        'name': context.translate.total_sale,
        "path": '${AppRoutes.saleAnalytics}/${AppRoutes.totalSale}',
        'icon': Image.asset(AssetPaths.sale),
      },

      // categories
      {
        'name': context.translate.total_revenue,
        "path": '${AppRoutes.saleAnalytics}/${AppRoutes.totalRevenue}',
        'icon': Image.asset(AssetPaths.revenue)
      },
      // Buy Products
      {
        'name':  context.translate.product,
        "path": '${AppRoutes.saleAnalytics}/${AppRoutes.productAnalyticsList}',
        'icon': Image.asset(AssetPaths.productAnalysis)
      },
      // buying history
      {
        'name': context.translate.category,
        "path": '${AppRoutes.saleAnalytics}/${AppRoutes.categoryAnalytics}',
        'icon': Image.asset(AssetPaths.catAnalysis)
      },
      // buying history
      {
        'name': context.translate.expenses,
        "path": '${AppRoutes.saleAnalytics}/${AppRoutes.expensesAnalytics}',
        'icon': Image.asset(AssetPaths.expenses)
      },
      // buying history
      {
        'name': context.translate.trending,
        "path": '${AppRoutes.saleAnalytics}/${AppRoutes.trendingAnalytics}',
        'icon': Image.asset(AssetPaths.trending)
      },
      
    ];
    
    final textStyle = TextTheme.of(context);

    double maxGridItemWidth = AppConstants.gridCardPrefiredWidth;
    // screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // caluculate proper number of items in one row
    int itemsPerRow = (screenWidth / maxGridItemWidth).floor();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.s10),
        child: Column(
          children: [
            GridView.builder(
              padding: const  EdgeInsets.symmetric(vertical: AppSizes.s30),
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
                textStyle,
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
