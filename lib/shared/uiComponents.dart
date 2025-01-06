// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, unused_element, file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/shared/assetPaths.dart';
import 'package:shop_owner/shared/imageDisplayer.dart';
import 'package:shop_owner/shared/uiHelper.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

Widget gap({double width = 0.0, double height = 0.0}) {
  return SizedBox(
    width: width,
    height: height,
  );
}

class _LanguageListTile extends StatefulWidget {
  const _LanguageListTile({super.key});

  @override
  State<_LanguageListTile> createState() => _LanguageListTileState();
}

class _LanguageListTileState extends State<_LanguageListTile> {
  late String current;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    current = Localizations.localeOf(context).toString();
    final String currentLanguage = context.languageName;
    final String currentCode = context.local.toString();
    final String currentFlag = context.flag;
    final _textStyle = Theme.of(context).textTheme;
    return ListTile(
      onTap: () async {
        await showChangeLanguage(context);
      },
      trailing: Container(
        margin: EdgeInsets.symmetric(
            horizontal: AppSizes.s4, vertical: AppSizes.s2),
        height: AppSizes.s35,
        width: AppSizes.s45,
        child: Image.asset(
          currentFlag,
          fit: BoxFit.cover,
        ),
      ),
      leading: Text(
        context.translate.language,
        style: _textStyle.displayLarge,
      ),
    );
  }
}

Widget changeLanguageTile() {
  return const _LanguageListTile();
}

Widget networkImageWithPlaceholder(String imageUrl) {
  print("image user is  : $imageUrl");
  return CachedNetworkImage(
    imageUrl: imageUrl,
    placeholder: (context, url) {
      print('this is the palce holder callback secion..');

      return Image.asset(
        AssetPaths.placeHolder, // Your placeholder image
        fit: BoxFit.cover,
      );
    },
    errorWidget: (context, url, error) {
      print(error);
      return Image.asset(
        AssetPaths.placeHolder, // Your error image
        fit: BoxFit.cover,
      );
    },
    fadeInDuration: const Duration(milliseconds: 500),
    fadeOutDuration: const Duration(milliseconds: 500),
    fit: BoxFit.cover,
    memCacheWidth: 2000,
    memCacheHeight: 2000,
  );
}

Color _getStockColor(int stok, TextTheme theme) {
  if (stok <= 0) {
    return AppColors.error;
  } else if (stok <= 5) {
    return AppColors.warning;
  } else {
    return theme.bodyLarge!.color!;
  }
}

String _trimName(ProductModel product) {
  int maxLength = 20;
  if (product.name.length > maxLength) {
    return '${product.name.substring(0, maxLength)}...';
  }
  return product.name;
}

String _trimDescription(ProductModel product) {
  int maxLength = 100;
  if (product.description.length > maxLength) {
    return '${product.description.substring(0, maxLength)}...';
  }
  return product.description;
}

Widget productCardMainSection({
  required ProductModel product,
  required bool isLTR,
  bool isCart = false, 
}) {
  return Builder(
    builder: (context) {
      final _textStyle = Theme.of(context).textTheme;

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
                        bottomLeft: isCart ? 0: AppSizes.s16,
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
                      style: _textStyle.bodyLarge!.copyWith(
                          color: _getStockColor(product.quantity, _textStyle)),
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
                            _trimName(product),
                            textDirection: TextDirection.ltr,
                            style: _textStyle.bodyMedium!.copyWith(
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
                              _trimDescription(product),
                              textDirection: TextDirection.ltr,
                              style: _textStyle.bodySmall,
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
                        style: _textStyle.bodySmall!.copyWith(
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
                    bottomLeft: isCart ? 0:   AppSizes.s16 ,
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
                            _trimName(product),
                            style: _textStyle.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Opacity(
                      opacity: 0.7,
                      child: Text(
                        _trimDescription(product),
                        style: _textStyle.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),

              // quantity
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    product.quantity.toString(),
                    style: _textStyle.bodyLarge,
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
                      style: _textStyle.bodySmall!.copyWith(
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
