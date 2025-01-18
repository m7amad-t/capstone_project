part of 'expenses_bloc_bloc.dart';

sealed class ExpensesBlocEvent extends Equatable {
  const ExpensesBlocEvent();

  @override
  List<Object> get props => [];
}



final class LoadExpenses  extends ExpensesBlocEvent{
}



final class ReloadExpenses  extends ExpensesBlocEvent{
}

final class DeleteExpense  extends ExpensesBlocEvent{


  final ExpensesModel expenseType ;

  const DeleteExpense({required this.expenseType}); 

  @override
  List<Object> get props => [expenseType];

}



final class AddNewExpenses extends ExpensesBlocEvent{
  final BuildContext context;
  final ExpensesModel newExpenses;

  const AddNewExpenses({required this.newExpenses , required this.context}); 


  @override
  List<Object> get props => [newExpenses , context];
}

final class AddExpensesRecord extends ExpensesBlocEvent{
  final BuildContext context;
  final ExpensesRecordsModel record;
  final ExpensesModel expensesModel;
  const AddExpensesRecord({required this.record , required this.expensesModel , required this.context}); 


  @override
  List<Object> get props => [record , context , expensesModel];
}