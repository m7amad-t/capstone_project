import 'package:equatable/equatable.dart';

class ExpensesModel extends Equatable {
  final String name;
  final int id;

  const ExpensesModel({
    required this.name,
    required this.id,
  });

  factory ExpensesModel.fromJson(Map<String, dynamic> data) {

    return ExpensesModel(
      id: data["id"],
      name: data["name"],
    );
  }

  static List<ExpensesModel> listFromJson(Map<String, dynamic> data) {
    List<ExpensesModel> expenses = [];

    for (final records in data['expenses']) {
      expenses.add(ExpensesModel.fromJson(records));
    }
    return expenses;
  }

  ExpensesModel update(Map<String, dynamic> data) {
    return ExpensesModel(
      id: data['id'] ?? id,
      name: data['name'] ?? name,
    );
  }

  @override
  List<Object?> get props => [id, name, ];
}
