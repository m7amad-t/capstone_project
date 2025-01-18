import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/shared/constants.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';

class AppLoadingCards extends StatelessWidget {
  static Widget productListPresenterTamplate() {
    return Builder(builder: (context) {
      return SingleChildScrollView(
        child: RepaintBoundary(
          child: Column(
            children: [
              gap(height: AppSizes.s10),
              Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor,
                highlightColor:
                    Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(20),
                loop: 10,
                // period: Duration(milliseconds: duration),
                child: Container(
                  height: AppSizes.s50,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(AppSizes.s8),
                          ),
                        ),
                      ),
                      gap(width: AppSizes.s10),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(AppSizes.s8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              gap(height: AppSizes.s10),
              Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor,
                highlightColor:
                    Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(20),
                loop: 10,
                // period: Duration(milliseconds: duration),
                child: Container(
                  height: AppSizes.s60,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(AppSizes.s8),
                          ),
                        ),
                      ),
                      gap(width: AppSizes.s10),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(AppSizes.s8),
                          ),
                        ),
                      ),
                      gap(width: AppSizes.s10),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(AppSizes.s8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // gap(height: AppSizes.s10),
              AppLoadingCards(
                height: AppSizes.s150,
                cards: 6,
              ),
            ],
          ).paddingSymmetric(horizontal: AppPaddings.p10),
        ),
      );
    });
  }

  static Widget grid(int count) {
    return Builder(builder: (context) {
      double maxGridItemWidth = AppConstants.gridCardPrefiredWidth;

      // screen width
      double screenWidth = MediaQuery.of(context).size.width;

      // caluculate proper number of items in one row
      int itemsPerRow = (screenWidth / maxGridItemWidth).floor();

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.s20,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: itemsPerRow,
          childAspectRatio: 1,
          crossAxisSpacing: AppSizes.s10,
          mainAxisSpacing: AppSizes.s10,
        ),
        itemCount: count,
        itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: Theme.of(context).cardColor,
                highlightColor:
                    Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(20),
                loop: 10,
                child: Card(
                ),
                
        ),
      );
    });
  }

  // {required double height, int duration = 1500}
  final double height;
  final int duration;
  final int cards;

  const AppLoadingCards({
    super.key,
    required this.height,
    this.cards = 10,
    this.duration = 1500,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cards,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Theme.of(context).cardColor.withAlpha(250),
        highlightColor:
            Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(20),
        loop: 10,
        period: Duration(milliseconds: duration),
        child: Card(
          child: SizedBox(
            height: height,
          ),
        ),
      )
          .paddingSymmetric(
            vertical: AppPaddings.p10,
          )
          .marginOnly(
            top: index == 0 ? AppSizes.s30 : 0,
          ),
    );
  }
}
