
// ignore_for_file: constant_identifier_names, camel_case_extensions, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

enum MONTHS{

  JANUARY,
  FEBRUARY,
  MARCH,
  APRIL,
  MAY,
  JUNE,
  JULY,
  AUGUST,
  SEPTEMBER,
  OCTOBER,
  NOVEMBER,
  DECEMBER

}

final List<MONTHS> MONTHES_LIST = [
  
  MONTHS.JANUARY,
  MONTHS.FEBRUARY,
  MONTHS.MARCH,
  MONTHS.APRIL,
  MONTHS.MAY,
  MONTHS.JUNE,
  MONTHS.JULY,
  MONTHS.AUGUST,
  MONTHS.SEPTEMBER,
  MONTHS.OCTOBER,
  MONTHS.NOVEMBER,
  MONTHS.DECEMBER
]; 


MONTHS monthFromInt(int index){

  if(index < 0 || index >= MONTHES_LIST.length) {
    return MONTHS.JANUARY;
  }
  return MONTHES_LIST[index];
}

int monthToInt(MONTHS month){
  return MONTHES_LIST.indexWhere((element) => element == month); 
}


extension MONTHS_EXT on MONTHS {
  int get index {
  return MONTHES_LIST.indexWhere((element) => element == this); 
}



  String name(BuildContext context){
    switch(this){
      case MONTHS.JANUARY:
        return context.translate.january;
      case MONTHS.FEBRUARY:
        return context.translate.february;
      case MONTHS.MARCH:
        return context.translate.march; 
      case MONTHS.APRIL:
        return context.translate.april;
      case MONTHS.MAY:
        return context.translate.may;
      case MONTHS.JUNE:
        return context.translate.june;
      case MONTHS.JULY:
        return context.translate.july;
      case MONTHS.AUGUST:
        return context.translate.august; 
      case MONTHS.SEPTEMBER:
        return context.translate.september;
      case MONTHS.OCTOBER:
        return context.translate.october;
      case MONTHS.NOVEMBER:
        return context.translate.november;
      case MONTHS.DECEMBER:
        return context.translate.december;
    }

  }

  

}
