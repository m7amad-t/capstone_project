import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/DamagedProducts/logic/models/DamagedProductsModel.dart';
import 'package:shop_owner/shared/UI/imageDisplayer.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class DamagedProductCard extends StatelessWidget {
  final DamagedProductsModel record;
  const DamagedProductCard({super.key, required this.record});

  double get totalLost {
    return record.boughtedPrice * record.quantity;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: SizedBox(
              width: AppSizes.s400,
              child: Card(
                  child: SizedBox(
                height: AppSizes.s180,
                child: _topSection(
                  textStyle,
                  context.fromLTR,
                  context,
                ),
              )),
            ),
          ),
        );
      },
    );
  }

  Widget _topSection(TextTheme textStyle, bool isLTR, BuildContext context) {
    if (isLTR) {
      return Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: AppSizes.s180,
                  child: ClipRect(
                    child: ImageDisplayerWithPlaceHolder(
                      imageUrl: record.product.imageUrl,
                      bottomLeft: AppSizes.s16,
                      topLeft: AppSizes.s16,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                    height: AppSizes.s180,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Theme.of(context).cardColor,
                          Theme.of(context).cardColor.withOpacity(0.9),
                          Theme.of(context).cardColor.withOpacity(0.6),
                          Theme.of(context).cardColor.withOpacity(0.0),
                        ],
                      ),
                    ),
                    child: Container()),
              ),
              Expanded(
                flex: 5,
                child: Container(),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),

          //  texts
          Row(
            children: [
              Expanded(flex: 2, child: Container()),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          _trimName(record.product.name),
                          style: textStyle.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    gap(height: AppSizes.s10),
                    _info(
                      textStyle: textStyle,
                      isLTR: isLTR,
                      lable: context.translate.purchase_cost,
                      value: "\$${record.boughtedPrice.toStringAsFixed(2)}",
                    ),
                    gap(height: AppPaddings.p10),
                    _info(
                      textStyle: textStyle,
                      isLTR: isLTR,
                      lable: context.translate.total_lost,
                      value: "\$${totalLost.toStringAsFixed(2)}",
                      valueColor: AppColors.error,
                    ),
                    gap(height: AppPaddings.p10),
                    Opacity(
                      opacity: 0.6,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _trimNote(record.note ?? ""),
                          style: textStyle.bodySmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    record.quantity.toString(),
                    style: textStyle.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.error,
                    ),
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(
            horizontal: AppPaddings.p10,
            vertical: AppPaddings.p14,
          ),
          // date
          Positioned(
            bottom: 0,
            left: AppPaddings.p10,
            right: AppPaddings.p10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  getAppDate(record.dateTime),
                )
              ],
            ),
          ),
        ],
      );
    }
    return Stack(
      children: [
        // background image
        Row(
          children: [
            Expanded(
              child: Container(),
            ),
            Expanded(
              flex: 5,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: AppSizes.s180,
                child: ClipRect(
                  child: ImageDisplayerWithPlaceHolder(
                    imageUrl: record.product.imageUrl,
                    bottomLeft: AppSizes.s16,
                    topLeft: AppSizes.s16,
                  ),
                ),
              ),
            ),
          ],
        ),

        // Gradient
        Row(
          children: [
            Expanded(
              child: Container(),
            ),
            Expanded(
              flex: 5,
              child: Container(),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: AppSizes.s180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      Theme.of(context).cardColor,
                      Theme.of(context).cardColor.withOpacity(0.9),
                      Theme.of(context).cardColor.withOpacity(0.6),
                      Theme.of(context).cardColor.withOpacity(0.0),
                    ],
                  ),
                ),
                child: Container(),
              ),
            ),
          ],
        ),

        //  texts
        Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  record.quantity.toString(),
                  style: textStyle.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.error,
                  ),
                ),
              ),
            ),
          
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _trimName(record.product.name),
                        style: textStyle.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  gap(height: AppSizes.s10),
                  _info(
                    textStyle: textStyle,
                    isLTR: isLTR,
                    lable: context.translate.purchase_cost,
                    value: "\$${record.boughtedPrice.toStringAsFixed(2)}",
                  ),
                  gap(height: AppPaddings.p10),
                  _info(
                    textStyle: textStyle,
                    isLTR: isLTR,
                    lable: context.translate.total_lost,
                    value: "\$${totalLost.toStringAsFixed(2)}",
                    valueColor: AppColors.error,
                  ),
                  gap(height: AppPaddings.p10),
                  Opacity(
                    opacity: 0.6,
                    child: Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _trimNote(record.note ?? ""),
                          style: textStyle.bodySmall,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(flex: 2, child: Container()),
          
          ],
        ).paddingSymmetric(
          horizontal: AppPaddings.p10,
          vertical: AppPaddings.p14,
        ),
        // date
        Positioned(
          bottom: 0,
          left: AppPaddings.p10,
          right: AppPaddings.p10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                getAppDate(record.dateTime),
              )
            ],
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

  String _trimNote(String text) {
    int maxLength = 70;
    // first check if it contains enters
    if (text.contains('\n')) {
      text = text.split('\n')[0];
    }
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }

  // info
  Widget _info({
    required TextTheme textStyle,
    required bool isLTR,
    required String lable,
    required String value,
    Color? valueColor,
  }) {
    if (isLTR) {
      return Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lable,
                  style: textStyle.bodyMedium!.copyWith(
                      // fontWeight: FontWeight.bold,
                      // color: AppColors.warning,
                      ),
                ),
                Text(
                  value,
                  style: textStyle.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: valueColor,
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
      );
    }

    return Row(
      children: [
        Expanded(
          child: Container(),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: textStyle.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: valueColor,
                  // color: AppColors.warning,
                ),
              ),
              Text(
                lable,
                style: textStyle.bodyMedium!.copyWith(
                    // fontWeight: FontWeight.bold,
                    // color: AppColors.warning,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
