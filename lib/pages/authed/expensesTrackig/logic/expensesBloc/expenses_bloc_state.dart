part of 'expenses_bloc_bloc.dart';

sealed class ExpensesBlocState extends Equatable {
  const ExpensesBlocState();
  
  @override
  List<Object> get props => [];
}

final class LoadingExpenses extends ExpensesBlocState {}


final class FailedToLoadExpenses extends ExpensesBlocState {}

final class GotExpenses extends ExpensesBlocState {


  final List<ExpensesModel> expenses;
  final bool isEnded; 
  const GotExpenses({required this.expenses , required this.isEnded}); 
  

  @override
  List<Object> get props => [expenses , isEnded];


}

