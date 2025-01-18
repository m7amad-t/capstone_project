import 'package:equatable/equatable.dart';

class ExpensesRecordsModel extends Equatable {
  final int id;
  final double amount;
  final DateTime date;
  final String? note;

  const ExpensesRecordsModel({
    required this.id,
    required this.amount,
    required this.date,
    required this.note,
  });

  factory ExpensesRecordsModel.fromJson(Map<String, dynamic> data) {
    return ExpensesRecordsModel(
      id: data['id'],
      amount: data['amount'],
      date: DateTime.parse(data['dateTime']),
      note: data['note'],
    );
  }

  static List<ExpensesRecordsModel> listFromJson(Map<String, dynamic> data) {
    List<ExpensesRecordsModel> records = [];

    for (final record in data['records']) {
      records.add(ExpensesRecordsModel.fromJson(record));
    }

    return records;
  }

  @override
  List<Object?> get props => [id , amount , date , note ?? "" ,]; 
}
