import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/monthsEnum.dart';

class TotalRevenueModel extends Equatable {

  final double totalRevenue;
  final DateTimeRange range;
  final List<MonthRevenueModel> months ;

  const TotalRevenueModel({required this.totalRevenue, required this.range, required this.months});
  
  @override
  List<Object?> get props => [totalRevenue , range , months];  


  factory TotalRevenueModel.fromJson(Map<String , dynamic> data){
    List<MonthRevenueModel> months = []; 

    for(final record in data['months']){
      months.add(MonthRevenueModel.fromJson(record));
    }

    DateTime start = DateTime.parse(data['startDate']); 
    DateTime end = DateTime.parse(data['endDate']); 

    // this sorting only for local , it should be done from backend 
    months.sort((a ,b) => a.month.index - b.month.index) ; 

    return TotalRevenueModel(
      totalRevenue: data['total_revenue'],
      range: DateTimeRange(start: start , end : end),
      months: months,
    );
  }

}


class MonthRevenueModel extends Equatable {
  
  final MONTHS month; 
  final String year ; 
  final double revenue ;

  const MonthRevenueModel({required this.month, required this.year, required this.revenue}); 
  @override
  List<Object?> get props => [month , year , revenue]; 


  factory MonthRevenueModel.fromJson(Map<String , dynamic> data){
    return MonthRevenueModel(
      month: monthFromInt(data['month']), 
      year: data['year'],
      revenue: data['revenue'],
    );
  }

}


class YearRevenueModel extends Equatable {

  final DateTime year ; 
  final double revenue ;

  const YearRevenueModel({required this.year, required this.revenue});
  
  @override
  List<Object?> get props => [year , revenue];  

  factory YearRevenueModel.fromJson(Map<String , dynamic> data){

    return YearRevenueModel(
      revenue: data['revenue'], 
      year: DateTime.parse(data['year']),
    ); 

  }

}



class RevenueModel extends Equatable {
  final double revenue;
  final DateTimeRange range;

  const RevenueModel({required this.revenue, required this.range});

  @override
  List<Object?> get props => [revenue, range];

  factory RevenueModel.fromJson(Map<String, dynamic> data) {
    DateTime start = data["startDate"];
    DateTime end = data["endDate"];
    return RevenueModel(
      revenue: data['revenue'],
      range: DateTimeRange(end: end, start: start),
    );
  }
}
