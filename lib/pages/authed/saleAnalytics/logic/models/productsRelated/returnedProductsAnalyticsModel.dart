import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/monthsEnum.dart';

class ReturnedProductsAnalyticsModel extends Equatable {
  final List<ReturnedProductAnalyticsModel> products;
  final DateTimeRange range;

  const ReturnedProductsAnalyticsModel(
      {required this.products, required this.range});
  @override
  List<Object?> get props => [products, range];

  factory ReturnedProductsAnalyticsModel.fromJson(Map<String, dynamic> data) {
    DateTime start = data["startDate"];
    DateTime end = data["endDate"];
    return ReturnedProductsAnalyticsModel(
      products: data['products'].map((e) => ReturnedProductAnalyticsModel.fromJson(e)).toList(),
      range: DateTimeRange(start: start, end: end),
    );
  }
}

class ReturnedProductAnalyticsModel extends Equatable {
  final String productName;
  final int totalProducts;
  final int id;
  final DateTimeRange range;
  final List<ProductMonthReturnedModel> months; 
  const ReturnedProductAnalyticsModel({
    required this.productName,
    required this.id,
    required this.totalProducts,
    required this.range,
    required this.months,
  });

  @override
  List<Object?> get props => [
        id,
        totalProducts,
        productName,
        range,
        months,
      ];

  factory ReturnedProductAnalyticsModel.fromJson(Map<String, dynamic> data) {
    DateTime start = DateTime.parse(data["startDate"]);
    DateTime end = DateTime.parse(data["endDate"]);
    List<ProductMonthReturnedModel> months = []; 

    for(final row in data['months']){
      months.add(ProductMonthReturnedModel.fromJson(row));
    }

    months.sort((a , b) => a.month.index - b.month.index); 
    
    return ReturnedProductAnalyticsModel(
      months: months,
      productName: data['productName'],
      id: data['id'],
      totalProducts: data['totalProducts'],
      range: DateTimeRange(start: start, end: end),
    );
  }
}


class ProductMonthReturnedModel extends Equatable {
  final int returned;
  final MONTHS month;

  const ProductMonthReturnedModel({required this.returned, required this.month});

  @override
  List<Object?> get props => [month,returned ];

  factory ProductMonthReturnedModel.fromJson(Map<String, dynamic> data) {
    return ProductMonthReturnedModel(
      returned: data['returned'],
      month: monthFromInt(data['month']),
    );
  }
}
