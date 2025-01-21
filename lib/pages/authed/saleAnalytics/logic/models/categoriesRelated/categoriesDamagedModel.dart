import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoriesDamagedModel extends Equatable {
  final List<CategoryDamagedModel> categories;
  final DateTimeRange range;
  final int totalDamaged;

  const CategoriesDamagedModel({
    required this.categories,
    required this.totalDamaged,
    required this.range,
  });

  @override
  List<Object?> get props => [categories, range,totalDamaged];

  factory CategoriesDamagedModel.fromJson(Map<String, dynamic> data) {
    DateTime start = DateTime.parse(data["startDate"]);
    DateTime end = DateTime.parse(data["endDate"]);

    List<CategoryDamagedModel> result = [];

    for (final record in data['categories']) {
      result.add(CategoryDamagedModel.formJson(record));
    }
    return CategoriesDamagedModel(
      categories: result,
      range: DateTimeRange(start: start, end: end),
      totalDamaged: data['totalDamaged'],
    );
  }
}

class CategoryDamagedModel extends Equatable {
  final String name;
  final int damaged;
  final int id;

  const CategoryDamagedModel(
      {required this.name, required this.damaged, required this.id});

  @override
  List<Object?> get props => [name, damaged, id];

  factory CategoryDamagedModel.formJson(Map<String, dynamic> data) {
    return CategoryDamagedModel(
      id: data['id'],
      name: data['name'],
      damaged: data['damaged'],
    );
  }
}
