

import 'package:flutter/material.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

enum ANALYTICS_OPTIONS{
  SALE, 
  REVENUE, 
  RETURNED,
  DAMAGED, 
}

final  List<ANALYTICS_OPTIONS> LIST_ANALYTICS_OPTIONS = [
  ANALYTICS_OPTIONS.SALE, 
  ANALYTICS_OPTIONS.REVENUE, 
  ANALYTICS_OPTIONS.RETURNED,
  ANALYTICS_OPTIONS.DAMAGED,
]; 

extension AnalytictsOptionsEx on ANALYTICS_OPTIONS{

  String name(BuildContext context){
    if(this == ANALYTICS_OPTIONS.SALE){
      return context.translate.sale; 
    }
    else if(this == ANALYTICS_OPTIONS.REVENUE){
      return context.translate.revenue; 
    }
    else if(this == ANALYTICS_OPTIONS.DAMAGED){
      return context.translate.damaged; 
    }else {
      return context.translate.returned; 

    }
  }

}