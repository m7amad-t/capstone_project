import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productReturnedModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productReturnsModel.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/fontSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ReturnedProductCard extends StatelessWidget {
  final ProductReturnedModel record;
  const ReturnedProductCard({super.key, required this.record});

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
            height: AppSizes.s150+20,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Row(
                    textDirection: TextDirection.ltr,
                    children: [
                      // center section
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            // product name
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _trimName(record.product),
                                  style: textStyle.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            // reason
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  record.reason.name,
                                  style: textStyle.bodySmall!.copyWith(
                                      color: AppColors.warning,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            // sold quantity
                            _info('Returned Quantity', record.returnedQuantity.toString()),

                            // total price
                            _info('Total',
                                _isHaveSellingRecord ? record.invoice!.total.toString() :"--" ),

                            // refund
                            _info('Refund', record.refund.toString()),
                            // sold quantity
                          ],
                        ),
                      ),
                      // right side returend quantity
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: AutoSizeText(
                           record.returnedQuantity.toString() ,
                            minFontSize: AppFontSizes.f26,
                            style: textStyle.displayLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //  timing section
                Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(
                            child: Icon(
                              Icons.logout_rounded,
                              color: AppColors.success,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                             _isHaveSellingRecord ? getAppDateTime(record.invoice!.time) : '--',
                              style: textStyle.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(
                            child: Icon(
                              Icons.login_rounded,
                              color: AppColors.error,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              getAppDateTime(record.date),
                              style: textStyle.bodySmall,
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
          // price
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

  Widget _info(String lable, String value) {
    return Builder(
      builder: (context) {
        final textStyle = Theme.of(context).textTheme;

        if (context.fromLTR) {
          return Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      lable,
                      style: textStyle.bodySmall!.copyWith(
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      value,
                      style: textStyle.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      textDirection: TextDirection.ltr,
                      style: textStyle.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      lable,
                      textDirection: TextDirection.ltr,
                      style: textStyle.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }


  String _trimName(ProductModel product) {
    int maxLength = 20;
    String name = product.name;
    // first check if it contains enters
    if (product.name.contains('\n')) {
      name = product.name.split('\n')[0];
    }
    if (name.length > maxLength) {
      return '${name.substring(0, maxLength)}...';
    }
    return name;
  }
}
