import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productReturnedModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productReturnsModel.dart';
import 'package:shop_owner/pages/authed/saleTracking/ui/components/sellingHistorycard.dart';
import 'package:shop_owner/shared/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/fontSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class NewReturnedProductCard extends StatelessWidget {
  final ProductReturnedModel record;
  const NewReturnedProductCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final bool _isHaveSellingRecord = record.invoice != null;
    return Card(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppPaddings.p10,
              vertical: AppPaddings.p6,
            ),
            child: Column(
              children: [
                gap(height: AppPaddings.p10),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                ),
                gap(height: AppSizes.s10), 
                if (record.invoice != null)
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
                if (record.invoice != null)
                Divider(
                  indent: AppSizes.s40,
                  height: 0,
                  endIndent:  AppSizes.s40,
                ), 
                if (record.invoice != null)
                  SellingHistoryCard(
                    record: record.invoice!,
                    isTapable: false,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.login_rounded,
                      color: AppColors.error,
                    ),
                    gap(width: AppSizes.s4),
                    Text(
                      getAppDateTime(record.date),
                      style: textStyle.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // price section 
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: context.fromLTR
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
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
            ),
          ),
        ],
      ),
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
