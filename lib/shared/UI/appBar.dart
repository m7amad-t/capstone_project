// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  String _title(BuildContext context, String location) {
    Map<String, String> locations = {
      AppRoutes.home: context.translate.home,
      AppRoutes.main: context.translate.home,
      AppRoutes.login: context.translate.signin,
      AppRoutes.productManagement: context.translate.product_management,
      AppRoutes.saleAnalytics: context.translate.analytics,
      // AppRoutes.saleTracking: context.translate.sale,
      AppRoutes.cart: "Cart",
      AppRoutes.expensesTracking:context.translate.expenses,
      AppRoutes.addProduct: context.translate.add_product,
      AppRoutes.editProduct: context.translate.updating_product,
      AppRoutes.product: context.translate.products,
      AppRoutes.category: context.translate.category,
      AppRoutes.addCategory: context.translate.add_category,
      AppRoutes.editCategory: context.translate.updating_product,
      AppRoutes.expensesTracking: context.translate.expenses,
      AppRoutes.cartCheckout: context.translate.check_out,
      AppRoutes.boughtedProducts: context.translate.purchase_history,
      AppRoutes.damagedProducts: context.translate.damaged_inventory,
      AppRoutes.productDetail: context.translate.product_details,
      AppRoutes.returnProductFrom: context.translate.return_product_form,
      AppRoutes.returnProductFromInvoice: context.translate.return_product_form,
      AppRoutes.returnedProduct: context.translate.returned_products,
      AppRoutes.buyProducts: context.translate.buy_product,
      AppRoutes.buyProductsFrom: context.translate.buying_product_from,
      AppRoutes.returnedProductsHistory: context.translate.purchase_history,
      AppRoutes.saleHistory: context.translate.sale_history,

    };

    for (final key in locations.keys) {
      if (location.endsWith(key)) {
        return locations[key]!;
      }
    }

    if (locations.containsKey(location)) {
      return locations[location]!;
    }

    return "ARCHiTECH";
  }

  bool _showBackButton(String location) {
    final List<String> primaryRoutes = [
      AppRoutes.home,
      AppRoutes.main,
      AppRoutes.login,
      AppRoutes.productManagement,
      AppRoutes.cart,
      AppRoutes.saleAnalytics,
      // AppRoutes.saleTracking,
      AppRoutes.expensesTracking
    ];
    if (primaryRoutes.contains(location)) {
      return false;
    }

    return true;
  }

  Widget _historyB(String path){

    return Builder(
      builder: (context) {
        return IconButton(onPressed: (){
          GoRouter.of(context).push(path); 
        }, icon: Icon(Icons.history , color:  AppColors.onPrimary , size : AppSizes.s35,),);
      }
    );

  }

  Widget? _historyButton(String location) {
    final List<Map<String, String>> histories = [
      // buy product page ..
      {
        'location' : AppRoutes.buyProducts,
         'path' :    AppRoutes.boughtedProducts,
      }
    ];


    for(int i  = 0 ; i < histories.length ; i++){

      if(location.endsWith(histories[i]['location']!)){
        return _historyB(histories[i]['path']!); 
      }

    }

    return null; 

  }

  bool _showTotalInCart(String location) {
    final List<String> primaryRoutes = [
      AppRoutes.cart,
    ];
    if (primaryRoutes.contains(location)) {
      return true;
    }

    return false;
  }

  bool _showSellingHistory(String location) {
    final List<String> primaryRoutes = [
      AppRoutes.home,
    ];
    if (primaryRoutes.contains(location)) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    final bool showBackButton = _showBackButton(location);
    // show history of selling button
    final bool showHOSRB = _showSellingHistory(location);
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.onPrimary,
                size: AppSizes.s30,
              ),
              onPressed: () => context.pop(),
            )
          : showHOSRB
              ? IconButton(
                  icon: Icon(
                    Icons.history_rounded,
                    color: AppColors.onPrimary,
                    size: AppSizes.s30,
                  ),
                  onPressed: () => GoRouter.of(context).push(
                    "${AppRoutes.home}/${AppRoutes.saleHistory}",
                  ),
                )
              : null,
      // actions: [

      //   _historyButton(location) ?? const SizedBox()
      // ],
      
      title: Text(
        _title(context, location),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
