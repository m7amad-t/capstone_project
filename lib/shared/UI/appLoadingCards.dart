import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/shared/constants.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';

class AppLoadingCards extends StatelessWidget {
  static Widget productListPresenterTamplate() {
    return RepaintBoundary(
      child: Builder(builder: (context) {
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
      }),
    );
  }

  static Widget grid(int count) {
    return RepaintBoundary(
      child: Builder(
        builder: (context) {
          double maxGridItemWidth = AppConstants.gridCardPrefiredWidth;
      
          // screen width
          double screenWidth = MediaQuery.of(context).size.width;
      
          // caluculate proper number of items in one row
          int itemsPerRow = (screenWidth / maxGridItemWidth).floor();
      
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
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
              child: const Card(),
            ),
          );
        },
      ),
    );
  }

  static Widget table(int rows, int columns) {
    return RepaintBoundary(
      child: Builder(
        builder: (context) {
          return Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: AppColors.primary,
                      highlightColor: Theme.of(context).scaffoldBackgroundColor,
                      // Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(20),
                      // loop: 10,
                      child: DataTable(
                        border: TableBorder.all(),
                        columnSpacing: AppPaddings.p10,
                        columns: [
                          for (int i = 1; i <= columns; i++)
                            DataColumn(
                              label: Container(
                                  // color : Colors.amber,
                                  // child: const SizedBox.shrink(),
                                  ),
                            ),
                        ],
                        rows: [
                          for (int i = 1; i <= rows; i++)
                            DataRow(
                              cells: [
                                for (int j = 1; j <= columns; j++)
                                  DataCell(Container(
                                    height: AppSizes.s120,
                                    margin: const EdgeInsets.all(AppSizes.s10),
                                    // color: AppColors.borderBrand,
                                  ))
                              ],
                            ),
                        ],
                      ),
                    ).paddingSymmetric(horizontal: AppPaddings.p10),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: AppSizes.s400,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              
                              Theme.of(context).scaffoldBackgroundColor, 
                              Theme.of(context).scaffoldBackgroundColor, 
                              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8), 
                              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7), 
                              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4), 
                              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2), 
                              Theme.of(context).scaffoldBackgroundColor.withOpacity(0), 
                            ],
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
      ),
    );
  }

  static Widget circle({double radius = AppSizes.s100 }) {
    return RepaintBoundary(
      child: Builder(
        builder: (context) {
          return Row(
            children: [
              Expanded(
                child: Shimmer.fromColors(
                  highlightColor: Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(20),
                  baseColor: Theme.of(context).scaffoldBackgroundColor,
                  // Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(20),
                  // loop: 10,
                  child: CircleAvatar(
                    radius: radius,
                  ),).paddingSymmetric(horizontal: AppPaddings.p10),
              ),
            ],
          );
        },
      ),
    );
  }

  // {required double height, int duration = 1500}
  final double height;
  final int duration;
  final int cards;
  final double topMargin;
  final double marginBetweenCard;
  final double? elevation ;

  const AppLoadingCards(
      {super.key,
      required this.height,
      this.cards = 10,
      this.marginBetweenCard = 10,
      this.elevation,
      this.duration = 1500,
      this.topMargin = 30});

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
          elevation: elevation ,
          child: SizedBox(

            height: height,
          ),
        ),
      )
          .paddingSymmetric(
            vertical: marginBetweenCard,
          )
          .marginOnly(
            top: index == 0 ? topMargin : 0,
          ),
    );
  }
}
