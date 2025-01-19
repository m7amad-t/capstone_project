// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/logic/models/productBoughtModel.dart';
import 'package:shop_owner/shared/UI/imageDisplayer.dart';
import 'package:shop_owner/shared/UI/priceWidget.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class BoughtedProductCard extends StatelessWidget {
  final ProductBoughtModel record;
  const BoughtedProductCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.s200,
      child: Card(
        child: _mainSection(),
      ),
    );
  }

  Widget _mainSection() {
    return Builder(
      builder: (context) {
        final textStyle = Theme.of(context).textTheme;
        final isLTR = context.fromLTR;

        if (!isLTR) {
          return Stack(
            children: [
              //  back  (image)
              Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: AppSizes.s200,
                      // width: 200,
                      child: ClipRect(
                        child: ImageDisplayerWithPlaceHolder(
                          imageUrl: record.product.imageUrl,
                          bottomLeft: AppSizes.s16,
                          topLeft: AppSizes.s16,
                        ),
                      ),
                      // child: Text('SLAAAAA'),
                    ),
                  ),
                ],
              ),

              //  middle (gradeant)
              Row(
                // mainAxisAlignment:
                //     isLTR ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      width: 200,
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
                      // child: Text('SLAAAAA'),
                    ),
                  ),
                ],
              ),

              // front texts
              Row(
                children: [
                  // name and description section
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        gap(height: AppPaddings.p10),
                        // name
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              _trimName(record.product.name),
                              textAlign: TextAlign.end,
                              textDirection: TextDirection.rtl,
                              style: textStyle.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        gap(height: AppPaddings.p10),
                        // quantity and price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (record.expireDate != null)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppPaddings.p6,
                                  vertical: AppPaddings.p4,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      getAppDate(record.expireDate!),
                                      style: textStyle.bodyMedium,
                                    ),
                                    gap(width: AppSizes.s10),
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      size: AppSizes.s20,

                                      // color: AppColors.primary,
                                    ),
                                  ],
                                ),
                              ).paddingOnly(
                                top: AppPaddings.p10,
                              ),

                            //  quantity
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppPaddings.p6,
                                  vertical: AppPaddings.p4,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      record.quantity.toString(),
                                      style: textStyle.bodyMedium,
                                    ),
                                    gap(width: AppSizes.s10),
                                    Icon(
                                      Icons.inventory_2_outlined,
                                      size: AppSizes.s20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        gap(height: AppPaddings.p6),

                        // total
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppPaddings.p6,
                                  vertical: AppPaddings.p4,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    PriceWidget(
                                      price: (record.pricePerItem *
                                          record.quantity),
                                      style: textStyle.bodyMedium!, 
                                    ),
                                    gap(width: AppSizes.s10),
                                    Icon(
                                      Icons.receipt_long_rounded,
                                      size: AppSizes.s20,
                                      // color: AppColors.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Opacity(
                          opacity: 0.7,
                          child: Text(
                            record.note ?? "",
                            style: textStyle.bodySmall,
                          ),
                        ).paddingSymmetric(horizontal: AppPaddings.p10),
                      ],
                    ),
                  ),

                  // gap on the image section
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                ],
              ),
              Positioned(
              left: AppPaddings.p10,
              right: AppPaddings.p10,
              bottom: AppPaddings.p4,
              child: Row(
                children: [
                  Text(
                    getAppDate(record.dateTime) , style: textStyle.bodySmall,
                  ), 
                  gap(width: AppSizes.s10),
                   Icon(
                    Icons.login,
                    color: AppColors.success,
                    size : AppSizes.s20, 
                  ),

                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Row(
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
                      child: PriceWidget(
                        price: record.pricePerItem,
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
          );
        }
        return Stack(
          children: [
            //  back  (image)
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    height: AppSizes.s200,
                    // width: 200,
                    child: ImageDisplayerWithPlaceHolder(
                      imageUrl: record.product.imageUrl,
                      bottomLeft: AppSizes.s16,
                      topLeft: AppSizes.s16,
                    ),
                    // child: Text('SLAAAAA'),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),

            //  middle (gradeant)
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    width: AppSizes.s200,
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
                    // child: Text('SLAAAAA'),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),

            // front texts
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      gap(height: AppPaddings.p10),
                      // name
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _trimName(record.product.name),
                              style: textStyle.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      gap(height: AppPaddings.p14),
                      // quantity and price
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppPaddings.p6,
                                vertical: AppPaddings.p4,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.inventory_2_outlined,
                                    size: AppSizes.s20,
                                    // color: AppColors.primary,
                                  ),
                                  gap(width: AppSizes.s10),
                                  Text(
                                    record.quantity.toString(),
                                    style: textStyle.bodyMedium, 
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (record.expireDate != null)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppPaddings.p6,
                                vertical: AppPaddings.p4,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    size: AppSizes.s20,

                                    // color: AppColors.primary,
                                  ),
                                  gap(width: AppSizes.s10),
                                  Text(
                                    getAppDate(record.expireDate!),
                                    style: textStyle.bodyMedium, 
                                  ),
                                ],
                              ),
                            ).paddingOnly(
                              top: AppPaddings.p10,
                            ),
                        ],
                      ),
                      gap(height: AppPaddings.p6),
                      // total and expire date
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppPaddings.p6,
                                vertical: AppPaddings.p4,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                   Icon(
                                    Icons.receipt_long_rounded,
                                    size : AppSizes.s20, 
                                    // color: AppColors.primary,
                                  ),
                                  gap(width: AppSizes.s10),
                                  PriceWidget(
                                    price:
                                        (record.pricePerItem * record.quantity),
                                    style: textStyle.bodyMedium!, 
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Expanded(
                          //   child: record.expireDate == null
                          //       ? const SizedBox()
                          //       : Container(
                          //           padding: EdgeInsets.symmetric(
                          //             horizontal: AppPaddings.p6,
                          //             vertical: AppPaddings.p4,
                          //           ),
                          //           child: Row(
                          //             mainAxisSize: MainAxisSize.min,
                          //             children: [
                          //               const Icon(
                          //                 Icons.calendar_month_outlined,
                          //                 // color: AppColors.primary,
                          //               ),
                          //               gap(width: AppSizes.s10),
                          //               Text(
                          //                 getAppDate(record.expireDate!),
                          //                 style: textStyle.bodyMedium!.copyWith(
                          //                     // fontWeight: FontWeight.bold,
                          //                     // color: AppColors.primary,
                          //                     ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          // )
                        ],
                      ),

                      gap(height: AppPaddings.p10),
                      // note
                      Opacity(
                        opacity: 0.5,
                        child: AutoSizeText(
                          _trimNote(record.note ?? ''),
                          style: textStyle.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Positioned(
              left: AppPaddings.p10,
              right: AppPaddings.p10,
              bottom: AppPaddings.p4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   Icon(
                    Icons.login,
                    color: AppColors.success,
                    size : AppSizes.s20, 
                  ),
                  gap(width: AppSizes.s10),
                  Text(
                    getAppDate(record.dateTime),
                    style: textStyle.bodySmall,
                  )
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                      child: PriceWidget(
                        price: record.pricePerItem,
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
        );
      },
    );
  }

  String _trimName(String text) {
    int max = 25;
    if (text.length < max) return text;

    return "${text.substring(0, max - 1)}...";
  }

  String _trimNote(String text) {
    int max = 70;
    if (text.length < max) return text;

    return "${text.substring(0, max - 1)}...";
  }
}
