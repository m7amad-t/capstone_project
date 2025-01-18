// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
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
                              style: textStyle.bodyMedium!.copyWith(
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

                            // price
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
                            
                                    PriceWidget(price: record.pricePerItem, style:  textStyle.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        // color: AppColors.primary,
                                      ), ), 
                                    
                                  ],
                                ),
                              ),
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
                                      style: textStyle.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        // color: AppColors.primary,
                                      ),
                                    ),
                                    gap(width: AppSizes.s10),

                                    const Icon(
                                      Icons.inventory_2_outlined,
                                      // color: AppColors.primary,
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
                              child: record.expireDate == null ?
                              const SizedBox() :  
                              
                              Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppPaddings.p6,
                                        vertical: AppPaddings.p4,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                         
                                          Text(
                                            getAppDate(record.expireDate ?? DateTime.now()),
                                            style:
                                                textStyle.bodyMedium!.copyWith(
                                              // fontWeight: FontWeight.bold,
                                              // color: AppColors.primary,
                                            ),
                                          ),
                                          gap(width: AppSizes.s10),

                                           const Icon(
                                            Icons.calendar_month_outlined,
                                            weight: 0.1,
                                            // color: AppColors.primary,
                                          ),
                                        ],
                                      ),
                                    ),
                            ), 
                          
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
                                    PriceWidget(price: (record.pricePerItem * record.quantity), style: textStyle.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        // color: AppColors.primary,
                                      ), ),
                                    
                                    gap(width: AppSizes.s10),

                                    const Icon(
                                      Icons.receipt_long_rounded,
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
                        ),
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
                              style: textStyle.bodyMedium!.copyWith(
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
                                  const Icon(
                                    Icons.inventory_2_outlined,
                                    // color: AppColors.primary,
                                  ),
                                  gap(width: AppSizes.s10),
                                  Text(
                                    record.quantity.toString(),
                                    style: textStyle.bodyMedium!.copyWith(
                                      // fontWeight: FontWeight.bold,
                                      // color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppPaddings.p6,
                                vertical: AppPaddings.p4,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // const Icon(
                                  //   Icons.trending_down,
                                  //   color: AppColors.primary,
                                  // ),
                                  gap(width: AppSizes.s10),
                                  PriceWidget(price: record.pricePerItem , style: textStyle.bodyMedium!.copyWith(
                                    ),),
                                  
                                ],
                              ),
                            ),
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
                                  const Icon(
                                    Icons.receipt_long_rounded,
                                    // color: AppColors.primary,
                                  ),
                                  gap(width: AppSizes.s10),
                                  PriceWidget(price: (record.pricePerItem * record.quantity), style: textStyle.bodyMedium!.copyWith(
                                    ), ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: record.expireDate == null
                                ? const SizedBox()
                                : Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: AppPaddings.p6,
                                      vertical: AppPaddings.p4,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.calendar_month_outlined,
                                          // color: AppColors.primary,
                                        ),
                                        gap(width: AppSizes.s10),
                                        Text(
                                          getAppDate(record.expireDate!),
                                          style:
                                              textStyle.bodyMedium!.copyWith(
                                            // fontWeight: FontWeight.bold,
                                            // color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          )
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
                const Icon(Icons.login , color : AppColors.success , ), 
                gap(width: AppSizes.s10), 
                Text(
                  getAppDate(record.dateTime), 

                )
              ],
            ),),
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
