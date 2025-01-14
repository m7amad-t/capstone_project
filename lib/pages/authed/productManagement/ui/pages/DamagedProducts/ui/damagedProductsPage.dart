import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/components/productListPresenter.dart';
import 'package:shop_owner/router/routes.dart';

class DamagedProductsPage extends StatelessWidget {
  const DamagedProductsPage({super.key});


  FloatingActionButton _button (BuildContext context){
    return FloatingActionButton(
      onPressed: () {
        GoRouter.of(context).go(
          "${AppRoutes.productManagement}/${AppRoutes.damagedProducts}/${AppRoutes.damagedProductsHistory}",
        ); 
      },
      child: const Icon(Icons.history),
    );
  }

  @override
  Widget build(BuildContext context) {
    String path = "${AppRoutes.productManagement}/${AppRoutes.damagedProducts}/${AppRoutes.damagedProductForm}";
    return ProductListPresenter(
      cardPath: path , 
      isCardTappable: true,
      costumFloating: _button(context), 

      ); 
  }
}