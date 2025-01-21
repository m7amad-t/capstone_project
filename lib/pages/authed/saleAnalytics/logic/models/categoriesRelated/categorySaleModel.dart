import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoriesSaleModel extends Equatable {
  final List<CategorySaleModel> categories;
  final DateTimeRange range;
  final double totalSale;

  const CategoriesSaleModel({
    required this.categories,
    required this.totalSale,
    required this.range,
  });
  @override
  List<Object?> get props => [categories, range, totalSale];

  factory CategoriesSaleModel.fromJson(Map<String, dynamic> data) {
    DateTime start = DateTime.parse(data["startDate"]);
    DateTime end = DateTime.parse(data["endDate"]);

    List<CategorySaleModel> result = [];

    for (final record in data['categories']) {
      result.add(CategorySaleModel.formJson(record));
    }
    return CategoriesSaleModel(
      categories: result,
      range: DateTimeRange(start: start, end: end),
      totalSale: data['totalSale'],
    );  
  }
}





class CategorySaleModel extends Equatable {
  final String name;
  final double sale;
  final int id;

  const CategorySaleModel(
      {required this.name, required this.sale, required this.id});

  @override
  List<Object?> get props => [name, sale, id];

  factory CategorySaleModel.formJson(Map<String, dynamic> data) {
    return CategorySaleModel(
      id: data['id'],
      name: data['name'],
      sale: data['totalSale'],
    );
  }
}
