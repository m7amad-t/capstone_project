import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/shared/UI/imageDisplayer.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ProductMainCardSection extends StatelessWidget {
  final bool isCart;
  final ProductModel product;
  const ProductMainCardSection({
    super.key,
    required this.product,
    this.isCart = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final bool isLTR = context.fromLTR; 
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
                    flex: 3,
                    child: SizedBox(
                      height: AppSizes.s120,
                      // width: 200,
                      child: ClipRect(
                        child: ImageDisplayerWithPlaceHolder(
                          imageUrl: product.imageUrl,
                          bottomLeft: isCart ? 0 : AppSizes.s16,
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
                    flex: 3,
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
                  // quantity section
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        product.quantity.toString(),
                        style: textStyle.bodyLarge!.copyWith(
                            color:
                                getStockColor(product.quantity, textStyle)),
                      ),
                    ),
                  ),

                  // name and description section
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        // name section
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.only(
                              top: AppSizes.s10,
                            ),
                            alignment: Alignment.topLeft,
                            child: Text(
                              trimName(product),
                              textDirection: TextDirection.ltr,
                              style: textStyle.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        // description section
                        Expanded(
                          flex: 4,
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Opacity(
                              opacity: 0.7,
                              child: Text(
                                trimDescription(product),
                                textDirection: TextDirection.ltr,
                                style: textStyle.bodySmall,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // gap on the image section
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),

              // price
              Positioned(
                top: 0,
                left: AppSizes.s10,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                          "\$${product.price}",
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
                  flex: 3,
                  child: SizedBox(
                    height: AppSizes.s120,
                    // width: 200,
                    child: ImageDisplayerWithPlaceHolder(
                      imageUrl: product.imageUrl,
                      bottomLeft: isCart ? 0 : AppSizes.s16,
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
                  flex: 3,
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
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              trimName(product),
                              style: textStyle.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Text(
                          trimDescription(product),
                          style: textStyle.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),

                // quantity
                Expanded(
                  child: Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      product.quantity.toString(),
                      maxLines: AppSizes.s24.toInt(),
                      style: textStyle.bodyLarge!.copyWith(
                        color: getStockColor(product.quantity, textStyle),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // price
            Positioned(
              top: 0,
              left: AppSizes.s10,
              right: 0,
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
                      child: Text(
                        "\$${product.price}",
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
}
