import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/components/productListPresenter.dart';
import 'package:shop_owner/router/routes.dart';

class ProductReturnPage extends StatelessWidget {
  const ProductReturnPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String cardTapPath =
        "${AppRoutes.productManagement}/${AppRoutes.product}/${AppRoutes.productDetail}";
    return ProductListPresenter(
      cardPath: cardTapPath,
      isCardTappable: true,
      // floatingButton: true,
    );
  }
}
