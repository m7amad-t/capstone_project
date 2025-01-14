import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/models/productReturnedModel.dart';
import 'package:shop_owner/pages/authed/saleTracking/ui/components/sellingHistorycard.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ReturnedProductCard extends StatelessWidget {
  final ProductReturnedModel record;
  const ReturnedProductCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          child: FittedBox(
          fit : BoxFit.fitWidth, 
          child: SizedBox(
            width: AppSizes.s400, 
            child: Card(
              child: Stack( 
                children: [
                  // card
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPaddings.p10,
                      vertical: AppPaddings.p6,
                    ),
                    child: Column(
                      children: [
                        // top gap
                        gap(height: AppPaddings.p10),
            
                        // top section (name , reason ,refund and quantity)
                        _topSection(textStyle, context.fromLTR),
            
                        gap(height: AppSizes.s10),
            
                        // invoce title
                        if (record.invoice != null) _invoceCardView(textStyle),
                        // date time and returned to..
                        _trailingSection(textStyle),
                      ],
                    ),
                  ),
            
                  // price section
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: _productPrice(context, textStyle),
                  ),
                ],
              ),
            ),
          ),
                ),
        );
   
      },
 );
  }

  Widget _topSection(TextTheme textStyle, bool isLTR) {
    if (isLTR) {
      return Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      _trimName(record.product.name),
                      style: textStyle.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                gap(height: AppSizes.s10),
                Row(
                  children: [
                    Text(
                      record.reason.name,
                      style: textStyle.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ),
                gap(height: AppSizes.s10),
                Row(
                  children: [
               
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Text(
                            "Refunded",
                            style: textStyle.displaySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              // color: AppColors.warning,
                            ),
                          ),
                          Text(
                            "\$${record.refund.toStringAsFixed(2)}",
                            style: textStyle.displaySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              // color: AppColors.warning,
                            ),
                          ),
                        
                        ],
                      ),
                    ),
                         Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                record.returnedQuantity.toString(),
                style: textStyle.displayLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              record.returnedQuantity.toString(),
              style: textStyle.displayLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                    isLTR ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  Text(
                    _trimName(record.product.name),
                    style: textStyle.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              gap(height: AppSizes.s10),
              Row(
                mainAxisAlignment:
                    isLTR ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  Text(
                    record.reason.name,
                    style: textStyle.displaySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.warning,
                    ),
                  ),
                ],
              ),
              gap(height: AppSizes.s10),
              Row(
                mainAxisAlignment:
                    isLTR ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${record.refund.toStringAsFixed(2)}",
                          style: textStyle.displaySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            // color: AppColors.warning,
                          ),
                        ),
                        Text(
                          "Refunded",
                          style: textStyle.displaySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            // color: AppColors.warning,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _invoceCardView(TextTheme textStyle) {
    return Column(
      children: [
        // invoice header..
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Invoice',
              style: textStyle.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        // devider
        Divider(
          indent: AppSizes.s40,
          height: 0,
          endIndent: AppSizes.s40,
        ),

        // invoice card
        LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: SizedBox(
                  width: 400,
                  child: SellingHistoryCard(
                    record: record.invoice!,
                    isTapable: false,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // this is the return date time , and return place
  Widget _trailingSection(TextTheme textStyle) {
    return Row(
      children: [
        Expanded(
          child: AutoSizeText(
            record.backToInventory
                ? "Back to inventory"
                : "Putted to Damaged Goods",
            style: textStyle.displaySmall,
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Icon(
                record.backToInventory
                    ? Icons.login_rounded
                    : Icons.logout_rounded,
                color: record.backToInventory
                    ? AppColors.success
                    : AppColors.error,
              ),
              gap(width: AppSizes.s4),
              Text(
                getAppDateTime(record.date),
                style: textStyle.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _productPrice(BuildContext context, TextTheme textStyle) {
    return Row(
      mainAxisAlignment:
          context.fromLTR ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppPaddings.p10,
            vertical: AppPaddings.p6,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppSizes.s16),
              bottomLeft: Radius.circular(AppSizes.s16),
              // bottomRight: Radius.circular(5),
            ),
            color: AppColors.primary.withAlpha(30),
          ),
          child: Opacity(
            opacity: 1,
            child: Text(
              "\$${record.product.price}",
              style: textStyle.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _trimName(String name) {
    int maxLength = 30;
    // first check if it contains enters
    if (name.contains('\n')) {
      name = name.split('\n')[0];
    }
    if (name.length > maxLength) {
      return '${name.substring(0, maxLength)}...';
    }
    return name;
  }
}
