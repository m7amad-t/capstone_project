import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/monthsEnum.dart';

class ProductRevenueModel extends Equatable {
  final String name;
  final double totalRevenue;
  final DateTimeRange range;
  final int id;
  final List<ProductMonthRevenueModel> months;

  const ProductRevenueModel({
    required this.name,
    required this.months,
    required this.totalRevenue,
    required this.range,
    required this.id,
  });

  @override
  List<Object?> get props => [name, id, totalRevenue, range];

  factory ProductRevenueModel.fromJson(Map<String, dynamic> data) {
    List<ProductMonthRevenueModel> months = [];
    for (final record in data['months']) {
      months.add(ProductMonthRevenueModel.fromJson(record));
    }
    months.sort((a ,b) => a.month.index - b.month.index) ; 

    DateTime start = DateTime.parse(data["startDate"]);
    DateTime end =  DateTime.parse(data["endDate"]);
    return ProductRevenueModel(
      name: data['name'],
      totalRevenue: data['revenue'],
      range: DateTimeRange(start: start, end: end),
      id: data['id'],
      months: months,
    );
  }
}

class ProductMonthRevenueModel extends Equatable {
  final double revenue;
  final MONTHS month;

  const ProductMonthRevenueModel({required this.revenue, required this.month});

  @override
  List<Object?> get props => [month, revenue];

  factory ProductMonthRevenueModel.fromJson(Map<String, dynamic> data) {
    return ProductMonthRevenueModel(
      revenue: data['revenue'],
      month: monthFromInt(data['id']),
    );
  }
}
