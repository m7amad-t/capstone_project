part of 'expenses_records_bloc_bloc.dart';

sealed class ExpensesRecordsBlocState extends Equatable {
  const ExpensesRecordsBlocState();
  
  @override
  List<Object> get props => [];
}

final class ExpensesRecordsLoading extends ExpensesRecordsBlocState {}


final class FaieldToLoadExpesesRecords extends ExpensesRecordsBlocState {}


final class GotExpesnsesRecords extends ExpensesRecordsBlocState {

  final List<ExpensesRecordsModel> records; 
  final DateTimeRange? lastRange ;

  const GotExpesnsesRecords({required this.records,  this.lastRange}); 

  @override
  List<Object> get props => [records, lastRange ?? ""];
}




