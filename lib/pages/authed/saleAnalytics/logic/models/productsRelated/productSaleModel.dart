import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/monthsEnum.dart';

class ProductSaleModel extends Equatable {
  final String name;
  final int id;
  final double totalSale;
  final List<ProductMonthSaleModel> months;
  final DateTimeRange range;

  const ProductSaleModel(
      {required this.name,
      required this.id,
      required this.totalSale,
      required this.months,
      required this.range});

  @override
  List<Object?> get props => [name, id, totalSale, months, range];

  factory ProductSaleModel.fromJson(Map<String, dynamic> data) {
    List<ProductMonthSaleModel> months = [];

    for (final record in data['months']) {
      months.add(ProductMonthSaleModel.fromJson(record));
    }

    DateTime start = DateTime.parse(data['startDate']);
    DateTime end = DateTime.parse(data['endDate']);
    months.sort((a ,b) => a.month.index - b.month.index) ; 

    return ProductSaleModel(
      name: data['name'],
      id: data['id'],
      totalSale: data['totalSale'],
      months: months,
      range: DateTimeRange(start: start, end: end),
    );
  }
}

class ProductMonthSaleModel extends Equatable {
  final MONTHS month;
  final double sale;

  const ProductMonthSaleModel({required this.month, required this.sale});

  @override
  List<Object?> get props => [month, sale];

  factory ProductMonthSaleModel.fromJson(Map<String, dynamic> data) {
    return ProductMonthSaleModel(
      month: monthFromInt(data['month']),
      sale: data['sale'],
    );
  }
}
