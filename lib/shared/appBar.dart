// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/saleAnalyticsPage.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/bloc/cart_bloc_bloc.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  String _title(BuildContext context, String location) {
    Map<String, String> locations = {
      AppRoutes.home: context.translate.home,
      AppRoutes.main: context.translate.home,
      AppRoutes.login: context.translate.login,
      AppRoutes.productManagement: context.translate.product_management,
      AppRoutes.saleAnalytics: context.translate.sale_analytics,
      AppRoutes.saleTracking: context.translate.sale,
      AppRoutes.cart: "Cart",
      AppRoutes.expensesTracking: context.translate.expenses_tracking,
      AppRoutes.product: context.translate.product,
      AppRoutes.addProduct: context.translate.add,
      AppRoutes.editProduct: context.translate.updating,
      AppRoutes.category: context.translate.category,
      AppRoutes.addCategory: context.translate.add,
      AppRoutes.editCategory: context.translate.updating,
      AppRoutes.expensesTracking: context.translate.expenses_tracking,
      AppRoutes.cartCheckout: "Checkout",
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
      AppRoutes.saleTracking,
      AppRoutes.expensesTracking
    ];
    if (primaryRoutes.contains(location)) {
      return false;
    }

    return true;
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

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    final bool showBackButton = _showBackButton(location);

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
          : null,
      title: Text(
        _title(context, location),
      ),
      centerTitle: true,

   );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
