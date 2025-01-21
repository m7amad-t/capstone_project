import 'package:flutter/material.dart';
import 'package:shop_owner/shared/UI/appLoadingCards.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';

class LoadingSkeletonOfAnalyticses extends StatelessWidget {
  final bool scrollable ;
  const LoadingSkeletonOfAnalyticses({super.key , this.scrollable = true});

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
        AppLoadingCards(
          height: AppSizes.s60,
          cards: 1,
          marginBetweenCard: 0,
          elevation: 0,
        ),
        // gap(height: AppSizes.s10),
        AppLoadingCards(
          height: AppSizes.s200,
          cards: 1,
          topMargin: 0,
          elevation: 0,
        ),
        gap(height: AppSizes.s50),
        AppLoadingCards.table(10, 2),
        gap(height: AppSizes.s50),
      ],
    );
  }

}