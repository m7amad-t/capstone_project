// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productCategoryModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/router/extraTemplates/productManagementExtra.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ProductCard extends StatelessWidget {
  final bool isReturnPageCard;
  final ProductModel product;
  final List<ProductCategoryModel> categories;
  const ProductCard({
    super.key,
    this.isReturnPageCard = false,
    required this.categories,
    required this.product,
  });

  void _navigateToReturnPage(BuildContext context) {
        GoRouter.of(context).push(
      "${AppRoutes.productManagement}/${AppRoutes.product}/${AppRoutes.editProduct}",
      extra: UpdateProductExtra(
        categories: categories,
        product: product,
      ).getExtra,
    );
  }

  void _navigateToDetailPage(BuildContext context) {
    GoRouter.of(context).push(
      "${AppRoutes.productManagement}/${AppRoutes.product}/${AppRoutes.productDetail}",
      extra: UpdateProductExtra(
        categories: categories,
        product: product,
      ).getExtra,
    );
  }

  void _tapCallback(BuildContext context) {
    if (isReturnPageCard) return _navigateToReturnPage(context);
    return _navigateToDetailPage(context);
  }

  @override
  Widget build(BuildContext context) {
    final isLTR = context.fromLTR;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: AppSizes.s120,
        maxWidth: AppSizes.s300,
      ),
      child: Card(
        child: InkWell(
          onTap: () {
            return _tapCallback(context);
          },
          child: productCardMainSection(
            product: product,
            isLTR: isLTR,
          ),
        ),
      ),
    );
  }

  
}
