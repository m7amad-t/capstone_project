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
  final ProductModel product;
  final List<ProductCategoryModel> categories;
  const ProductCard({
    super.key,
    required this.categories,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final isLTR = context.fromLTR;

    return InkWell(
      onTap: () {
        GoRouter.of(context).push(
          "${AppRoutes.productManagement}/${AppRoutes.product}/${AppRoutes.editProduct}",
          extra: UpdateProductExtra(
            categories: categories,
            product: product,
          ).getExtra,
        );
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: AppSizes.s120,
          maxWidth: AppSizes.s300,
        ),
        child: Card(
          child: productCardMainSection(
            product: product,
            isLTR: isLTR,
          ),
        ),
      ),
    );
  }

}
