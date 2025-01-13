// ignore_for_file: no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productCategoryModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/shared/imageDisplayer.dart';
import 'package:shop_owner/shared/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ProductCard extends StatelessWidget {
  final bool isReturnPageCard;
  final ProductModel product;
  final List<ProductCategoryModel> categories;
  final VoidCallback? onTapCallback;
  const ProductCard({
    super.key,
    this.isReturnPageCard = false,
    this.onTapCallback,
    required this.categories,
    required this.product,
  });

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
          onTap: onTapCallback,
          child: productCardMainSection(
            product: product,
            isLTR: isLTR,
          ),
        ),
      ),
    );
  }


}
