part of 'expenses_records_bloc_bloc.dart';

sealed class ExpensesRecordsBlocEvent extends Equatable {
  const ExpensesRecordsBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadExpenseRecords extends ExpensesRecordsBlocEvent {
  final ExpensesModel expesnes;
  const LoadExpenseRecords({required this.expesnes});

  @override
  List<Object> get props => [expesnes];
}

class LoadExpenseRecordsInRange extends ExpensesRecordsBlocEvent {
  final ExpensesModel expesnes;
  final DateTimeRange range; 
  const LoadExpenseRecordsInRange({required this.expesnes  , required this.range});

  @override
  List<Object> get props => [expesnes];
}

class ReloadExpenseRecords extends ExpensesRecordsBlocEvent {
  
}

class AddRecord extends ExpensesRecordsBlocEvent {
  final ExpensesModel expesnes;
  final ExpensesRecordsModel records;
  final BuildContext context;  

  const AddRecord({required this.expesnes, required this.context  , required this.records});

  @override
  List<Object> get props => [expesnes, records];
}

class DeleteRecord extends ExpensesRecordsBlocEvent {
  final ExpensesModel expesnes;
  final ExpensesRecordsModel records;

  const DeleteRecord({required this.expesnes, required this.records});

  @override
  List<Object> get props => [expesnes, records];
}


