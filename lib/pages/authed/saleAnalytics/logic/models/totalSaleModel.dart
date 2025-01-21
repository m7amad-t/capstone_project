// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/monthsEnum.dart';

class TotalSaleModel extends Equatable {
  final List<MonthSale> months;
  final DateTimeRange range;
  final double totalSale;

  const TotalSaleModel(
      {required this.months, required this.range, required this.totalSale});

  @override
  List<Object?> get props => [months, range, totalSale];


  factory TotalSaleModel.fromJson(Map<String, dynamic> data) {
    DateTime start = DateTime.parse(data["startDate"]);
    DateTime end = DateTime.parse(data["endDate"]);

    List<MonthSale> months = []; 

    for(final record in data['months']){
      months.add(MonthSale.fromJson(record));
    }

   

    months.sort((a ,b) => a.month.index - b.month.index) ; 

    return TotalSaleModel(
      months: months,
      totalSale: data['totalSale'],
      range: DateTimeRange(start: start, end: end),
    );
  }
}

class MonthSale extends Equatable {
  final double sale;
  final MONTHS month;

  const MonthSale({required this.sale, required this.month});
  @override
  List<Object?> get props => [sale, month];

  factory MonthSale.fromJson(Map<String, dynamic> data) {
    return MonthSale(
      sale: data['sale'],
      month: monthFromInt(data['month']),
    );
  }
}
