import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/monthsEnum.dart';

class DamagedProductsAnalyticsModel extends Equatable {
  final List<DamagedProductAnalyticsModel> products;
  final DateTimeRange range;

  const DamagedProductsAnalyticsModel(
      {required this.products, required this.range});

  @override
  List<Object?> get props => [products, range];

  factory DamagedProductsAnalyticsModel.fromJson(Map<String, dynamic> data) {
    DateTime start = data['startDate'];
    DateTime end = data['endDate'];

    return DamagedProductsAnalyticsModel(
      products: data['products']
          .map((e) => DamagedProductAnalyticsModel.fromJson(e))
          .toList(),
      range: DateTimeRange(end: end, start: start),
    );
  }
}

class DamagedProductAnalyticsModel extends Equatable {
  final String productName;
  final int id;
  final DateTimeRange range;
  final List<ProductMonthDamagedModel> months;
  final int  totalDamaged;
  final double totalLost;
  const DamagedProductAnalyticsModel({
    required this.months,
    required this.productName,
    required this.id,
    required this.range,
    required this.totalDamaged,
    required this.totalLost,
  });

  @override
  List<Object?> get props => [id, productName, range , months , totalDamaged , totalDamaged];

  factory DamagedProductAnalyticsModel.fromJson(Map<String, dynamic> data) {
    DateTime start = DateTime.parse(data['startDate']);
    DateTime end = DateTime.parse(data['endDate']);

    List<ProductMonthDamagedModel> months = []; 

    for(final row in data['months']){
      months.add(ProductMonthDamagedModel.fromJson(row));

    }

    months.sort((a , b) => a.month.index - b.month.index); 

    return DamagedProductAnalyticsModel(
      productName: data['productName'],
      id: data['id'],
      totalDamaged: data['totalDamaged'],
      totalLost: data['totalLost'],
      months: months,
      range: DateTimeRange(end: end, start: start),
    );
  }
}

class ProductMonthDamagedModel extends Equatable {
  final int damaged;
  final MONTHS month;
  final double lost; 

  const ProductMonthDamagedModel({required this.damaged, required this.lost ,required this.month});

  @override
  List<Object?> get props => [month, damaged];

  factory ProductMonthDamagedModel.fromJson(Map<String, dynamic> data) {
    return ProductMonthDamagedModel(
      damaged: data['damaged'],
      lost: data['lost'],
      month: monthFromInt(data['month']),
    );
  }
}
