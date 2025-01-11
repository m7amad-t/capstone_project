
// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DynamicSizes{

  final BuildContext context ; 

  DynamicSizes({required this.context});


  double get p30  => MediaQuery.of(context).size.width*0.3;   
  double get p35  => MediaQuery.of(context).size.width*0.35;   
  double get p40  => MediaQuery.of(context).size.width*0.4;   
  double get p45  => MediaQuery.of(context).size.width*0.45;   
  double get p50  => MediaQuery.of(context).size.width*0.5;   
  double get p55  => MediaQuery.of(context).size.width*0.55;   
  double get p60  => MediaQuery.of(context).size.width*0.6;   
  double get p65  => MediaQuery.of(context).size.width*0.65;   
  double get p70  => MediaQuery.of(context).size.width*0.7;   
  double get p75  => MediaQuery.of(context).size.width*0.75;   
  double get p80  => MediaQuery.of(context).size.width*0.8;   
  double get p85  => MediaQuery.of(context).size.width*0.85;   
  double get p90  => MediaQuery.of(context).size.width*0.9;   
  double get p95  => MediaQuery.of(context).size.width*0.95;   
  double get p100  => MediaQuery.of(context).size.width;   

}