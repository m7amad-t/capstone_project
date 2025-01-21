import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:shop_owner/shared/UI/priceWidget.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';

class TotalSection extends StatelessWidget {
  final String lable;
  final double value;
  final int? primaryValue; 
  const TotalSection({super.key, required this.lable, required this.value , this.primaryValue});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.p10, vertical: AppPaddings.p14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s8),
        color: AppColors.primary.withAlpha(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            lable,
            style: textStyle.bodyMedium,
          ),


          if(primaryValue != null)
          Text(
            primaryValue.toString(),
            style: textStyle.bodyMedium,
          ),
          if(primaryValue == null)
          PriceWidget(
            price: value,
            style: textStyle.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: AppPaddings.p10);
  }
}
