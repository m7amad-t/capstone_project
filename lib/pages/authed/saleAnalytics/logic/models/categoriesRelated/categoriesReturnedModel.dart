import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoriesReturnedModel extends Equatable {
  final List<CategoryReturnedModel> categories;
  final DateTimeRange range;
  final int totalReturned;

  const CategoriesReturnedModel({
    required this.categories,
    required this.totalReturned,
    required this.range,
  });

  @override
  List<Object?> get props => [categories, range,totalReturned];

  factory CategoriesReturnedModel.fromJson(Map<String, dynamic> data) {
    DateTime start = DateTime.parse(data["startDate"]);
    DateTime end = DateTime.parse(data["endDate"]);

    List<CategoryReturnedModel> result = [];

    for (final record in data['categories']) {
      result.add(CategoryReturnedModel.formJson(record));
    }
    return CategoriesReturnedModel(
      categories: result,
      range: DateTimeRange(start: start, end: end),
      totalReturned: data['totalReturned'],
    );
  }
}

class CategoryReturnedModel extends Equatable {
  final String name;
  final int returned;
  final int id;

  const CategoryReturnedModel(
      {required this.name, required this.returned, required this.id});

  @override
  List<Object?> get props => [name, returned, id];

  factory CategoryReturnedModel.formJson(Map<String, dynamic> data) {
    return CategoryReturnedModel(
      id: data['id'],
      name: data['name'],
      returned: data['returned'],
    );
  }
}
