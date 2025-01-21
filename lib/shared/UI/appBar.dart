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
      AppRoutes.profile: context.translate.profile,
      // AppRoutes.saleTracking: context.translate.sale,
      AppRoutes.cart: context.translate.cart,
      AppRoutes.expensesTracking: context.translate.expenses,
      AppRoutes.addProduct: context.translate.add_product,
      AppRoutes.editProduct: context.translate.updating_product,
      AppRoutes.product: context.translate.products,
      AppRoutes.editCategory: context.translate.edit_category,
      AppRoutes.addCategory: context.translate.add_category,
      AppRoutes.category: context.translate.category,
      AppRoutes.expensesTracking: context.translate.expenses,
      AppRoutes.cartCheckout: context.translate.check_out,
      AppRoutes.boughtedProducts: context.translate.purchase_history,
      AppRoutes.damagedProducts: context.translate.damaged,
      AppRoutes.damagedProductsHistory: context.translate.damaged_inventory,
      AppRoutes.damagedProductForm: context.translate.damaged_product_form,
      AppRoutes.productDetail: context.translate.product_details,
      AppRoutes.returnProductFrom: context.translate.return_product_form,
      AppRoutes.returnProductFromInvoice: context.translate.return_product_form,
      AppRoutes.returnedProduct: context.translate.return_a_product,
      AppRoutes.buyProducts: context.translate.buy_product,
      AppRoutes.buyProductsFrom: context.translate.buying_product_from,
      AppRoutes.returnedProductsHistory: context.translate.returned_products,
      AppRoutes.saleHistory: context.translate.sale_history,
      AppRoutes.addUser: context.translate.adding_new_user,
      AppRoutes.addExpesnesRecord: context.translate.incur_expense,
      AppRoutes.expensRecordHistory: context.translate.expense_history,
      AppRoutes.totalSale: context.translate.total_sale,
      AppRoutes.totalRevenue: context.translate.total_revenue,
      AppRoutes.productAnalyticsList: context.translate.products,
      AppRoutes.productAnalytics: context.translate.product_analytics,
      AppRoutes.categoryAnalytics: context.translate.categories_analytics,
      AppRoutes.expensesAnalytics: context.translate.expenses_analytics,
      AppRoutes.trendingAnalytics: context.translate.trending_product,
      AppRoutes.updateProfile: context.translate.updating_profile,


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
      AppRoutes.profile,
      AppRoutes.expensesTracking
    ];
    if (primaryRoutes.contains(location)) {
      return false;
    }

    return true;
  }

  Widget _historyB(String path) {
    return Builder(builder: (context) {
      return IconButton(
        onPressed: () {
          GoRouter.of(context).push(path);
        },
        icon: const Icon(
          Icons.history,
          color: AppColors.onPrimary,
          size: AppSizes.s35,
        ),
      );
    });
  }

  Widget? _historyButton(String location) {
    final List<Map<String, String>> histories = [
      // buy product page ..
      {
        'location': AppRoutes.buyProducts,
        'path': AppRoutes.boughtedProducts,
      }
    ];

    for (int i = 0; i < histories.length; i++) {
      if (location.endsWith(histories[i]['location']!)) {
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
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.onPrimary,
                size: AppSizes.s30,
              ),
              onPressed: () => context.pop(),
            )
          : showHOSRB
              ? IconButton(
                  icon: const Icon(
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
