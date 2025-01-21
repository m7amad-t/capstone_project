import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/components/productListPresenter.dart';
import 'package:shop_owner/router/routes.dart';

class ProductListPresenterForAnalytics extends StatefulWidget {
  const ProductListPresenterForAnalytics({super.key});

  @override
  State<ProductListPresenterForAnalytics> createState() =>
      _ProductListPresenterForAnalyticsState();
}

class _ProductListPresenterForAnalyticsState
    extends State<ProductListPresenterForAnalytics> {
  @override
  Widget build(BuildContext context) {
    String path = "${AppRoutes.saleAnalytics}/${AppRoutes.productAnalyticsList}/${AppRoutes.productAnalytics}";
    return ProductListPresenter(
      cardPath: path,
      isCardTappable: true,
    );
  }
}
