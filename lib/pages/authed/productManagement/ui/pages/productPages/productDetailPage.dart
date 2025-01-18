// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productCategoryModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/components/productHistorySection.dart';
import 'package:shop_owner/router/extraTemplates/productManagementExtra.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/UI/imageDisplayer.dart';
import 'package:shop_owner/shared/UI/priceWidget.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  final List<ProductCategoryModel> categories;
  const ProductDetailPage(
      {super.key, required this.product, required this.categories});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).push(
            "${AppRoutes.productManagement}/${AppRoutes.product}/${AppRoutes.productDetail}/${AppRoutes.editProduct}",
            extra: UpdateProductExtra(
              categories: widget.categories,
              product: widget.product,
            ).getExtra,
          );
        },
        child: Icon(
          Icons.edit_note_rounded,
          size: AppSizes.s30,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // unfocus any focused element
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              // top section , background image and avatar
              _topSecton(),

              _productName(context)
                  .paddingSymmetric(horizontal: AppPaddings.p10),

              gap(height: AppSizes.s10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _priceSection(textStyle),
                    gap(width: 10),
                    _quantitySection()
                  ],
                ),
              ),
              gap(height: AppSizes.s10),

              _discription(context)
                  .paddingSymmetric(horizontal: AppPaddings.p10),

              gap(height: AppSizes.s10),
              // product details section

              gap(height: AppSizes.s10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10),
                child: ProductHistorySection(
                  product: widget.product,
                ),
              ),

              // trailling gap
              SizedBox(height: AppSizes.s200),
            ],
          ),
        ),
      ),
    );
  }

// background image
  Widget _topSecton() {
    return SizedBox(
      width: AppSizes.infinity,
      height: AppSizes.s250,
      child: Stack(
        children: [
          // background image
          SizedBox(
            width: double.infinity,
            height: AppSizes.s250,
            child: ImageDisplayerWithPlaceHolder(
              imageUrl: widget.product.imageUrl,
            ),
          ),

          // background imaeg
          Container(
            // width: AppSizes.s300,
            height: AppSizes.s250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  // AppColors.primary,
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productName(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      alignment: context.fromLTR ? Alignment.topLeft : Alignment.topRight,
      child: Text(
        widget.product.name,
        textDirection: context.fromLTR ? TextDirection.ltr : TextDirection.rtl,
        style: textStyle.displayLarge,
      ),
    );
  }

  Widget _discription(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      alignment: context.fromLTR ? Alignment.center : Alignment.center,
      child: Text(
        widget.product.description,
        textDirection: context.fromLTR ? TextDirection.ltr : TextDirection.rtl,
        style: textStyle.displaySmall,
      ),
    );
  }

  Widget _priceSection(TextTheme textStyle) {
    return _template(
        context.translate.price, widget.product.price.toStringAsFixed(2),
        valueWidget: PriceWidget(
          price: widget.product.price,
          style: textStyle.bodyMedium!.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  Widget _quantitySection() {
    return _template(
      context.translate.quantity,
      widget.product.quantity.toString(),
    );
  }

  Widget _template(String lable, String value, {Widget? valueWidget}) {
    final textStyle = Theme.of(context).textTheme;

    return Expanded(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: AppSizes.s200,
          maxHeight: AppSizes.s50,
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: AppPaddings.p10,
            vertical: AppPaddings.p8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.s8),
            color: AppColors.primary.withAlpha(100),
          ),
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                lable,
                style: textStyle.bodyMedium!.copyWith(color: AppColors.primary),
              ),
              valueWidget ??
                  Text(
                    value,
                    style: textStyle.bodyMedium!.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
