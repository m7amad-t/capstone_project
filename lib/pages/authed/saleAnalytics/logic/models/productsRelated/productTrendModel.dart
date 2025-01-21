import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProductsTrendModel extends Equatable {
  final List<ProductTreandModel> categories;
  final DateTimeRange range;
  final int soldUnites;

  const ProductsTrendModel({
    required this.categories,
    required this.soldUnites,
    required this.range,
  });

  @override
  List<Object?> get props => [categories, range, soldUnites];

  factory ProductsTrendModel.fromJson(Map<String, dynamic> data) {
    DateTime start = DateTime.parse(data["startDate"]);
    DateTime end = DateTime.parse(data["endDate"]);

    List<ProductTreandModel> result = [];

    for (final record in data['categories']) {
      result.add(ProductTreandModel.formJson(record));
    }
    return ProductsTrendModel(
      categories: result,
      range: DateTimeRange(start: start, end: end),
      soldUnites: data['soldUnites'],
    );
  }
}

class ProductTreandModel extends Equatable {
  final String name;
  final int soldUnites;
  final int id;

  const ProductTreandModel({
    required this.name,
    required this.soldUnites,
    required this.id,
  });

  @override
  List<Object?> get props => [name, soldUnites, id];

  factory ProductTreandModel.formJson(Map<String, dynamic> data) {
    return ProductTreandModel(
      id: data['id'],
      name: data['name'],
      soldUnites: data['soldUnites'],
    );
  }
}
