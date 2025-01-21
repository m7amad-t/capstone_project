import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ExpensesAnalyticsModel extends Equatable {
  final List<ExpenseAnalyticsModel> expenses;
  final DateTimeRange range;
  final double total;

  const ExpensesAnalyticsModel({
    required this.expenses,
    required this.total,
    required this.range,
  });
  @override
  List<Object?> get props => [total , range, expenses];

  factory ExpensesAnalyticsModel.fromJson(Map<String, dynamic> data) {
    DateTime start = DateTime.parse(data["startDate"]);
    DateTime end = DateTime.parse(data["endDate"]);

    List<ExpenseAnalyticsModel> result = [];

    for (final record in data['expenses']) {
      result.add(ExpenseAnalyticsModel.formJson(record));
    }
    return ExpensesAnalyticsModel(
      expenses: result,
      range: DateTimeRange(start: start, end: end),
      total: data['total'],
    );  
  }
}

class ExpenseAnalyticsModel extends Equatable {
  final String name;
  final double total;
  final int id;

  const ExpenseAnalyticsModel(
      {required this.name, required this.total, required this.id});

  @override
  List<Object?> get props => [name, total, id];

  factory ExpenseAnalyticsModel.formJson(Map<String, dynamic> data) {
    return ExpenseAnalyticsModel(
      id: data['id'],
      name: data['name'],
      total: data['total'],
    );
  }
}
