// ignore_for_file: no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productCategoryModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/shared/UI/productMainCardSection.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';

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
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: AppSizes.s120,
        maxWidth: AppSizes.s300,
      ),
      child: Card(
        child: InkWell(
          onTap: onTapCallback,
          child: ProductMainCardSection(
            product: product,
          ),
        ),
      ),
    );
  }


}
