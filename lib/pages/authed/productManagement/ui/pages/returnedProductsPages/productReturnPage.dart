import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/components/productListPresenter.dart';
import 'package:shop_owner/router/routes.dart';

class ProductReturnPage extends StatelessWidget {
  const ProductReturnPage({super.key});


  FloatingActionButton _historyFloatingButton (BuildContext context){

    return FloatingActionButton(
      onPressed: () {
        GoRouter.of(context).go(
          "${AppRoutes.productManagement}/${AppRoutes.returnedProduct}/${AppRoutes.returnedProductsHistory}",
        ); 
      },
      child: const Icon(Icons.history),
    );

  }

  @override
  Widget build(BuildContext context) {
    final String cardTapPath =
        "${AppRoutes.productManagement}/${AppRoutes.returnedProduct}/${AppRoutes.returnProductFrom}";
    return ProductListPresenter(
      cardPath: cardTapPath,
      isCardTappable: true,
      costumFloating: _historyFloatingButton(context),
      // floatingButton: true,
    );
  }
}
