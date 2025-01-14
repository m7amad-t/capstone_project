import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';

class AppLoadingCards extends StatelessWidget {
  // {required double height, int duration = 1500}
  final double height;
  final int duration;
  const AppLoadingCards({super.key , required this.height , this.duration = 1500});

  @override
  Widget build(BuildContext context) {
    
  List<int> laodingCards = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  return ListView.builder(
    shrinkWrap: true,
    itemCount: laodingCards.length,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) => Shimmer.fromColors(
      baseColor: Theme.of(context).cardColor.withAlpha(250),
      highlightColor:
          Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(20),
      loop: 10,
      period: Duration(milliseconds: duration),
      child: SizedBox(
        height: height,
        child: const Card(),
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