import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_owner/shared/UI/appLoadingCards.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';

class AnalyticsPagesLoadingSkeleton extends StatelessWidget {
  final bool scrollable ;
  final bool circle ; 
  final double cardHeight ; 
  const AnalyticsPagesLoadingSkeleton({super.key , this.scrollable = true , this.circle = true , this.cardHeight = AppSizes.s250, });

  @override
  Widget build(BuildContext context) {
    if(scrollable) {
      return SingleChildScrollView(child: _loadingSkeleton(),); 
    }
    return _loadingSkeleton(); 
  }
  
  Widget _loadingSkeleton() {
    return Column(
      children: [
        const AppLoadingCards(
          height: AppSizes.s60,
          cards: 1,
          marginBetweenCard: 0,
          elevation: 0,
        ),
        gap(height: AppSizes.s20),

        circle ?AppLoadingCards.circle() : AppLoadingCards(
          height: cardHeight,
          cards: 1,
          marginBetweenCard: 0,
          elevation: 0,
        ) , 
        
        gap(height: AppSizes.s40),
        const AppLoadingCards(
          height: AppSizes.s60,
          cards: 1,
          marginBetweenCard: 0,
          elevation: 0,
        ).paddingSymmetric(horizontal: AppPaddings.p6),
        gap(height: AppSizes.s10),
        AppLoadingCards.table(10, 2),
        gap(height: AppSizes.s50),
      ],
    );
  }

}