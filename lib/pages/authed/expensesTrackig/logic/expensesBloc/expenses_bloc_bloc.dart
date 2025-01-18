// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/expensesModel.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/expensesRecords.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/services/expensesServices.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/UI/appDialogs.dart';
import 'package:shop_owner/shared/UI/uiHelper.dart';
import 'package:shop_owner/shared/models/snackBarMessages.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

part 'expenses_bloc_event.dart';
part 'expenses_bloc_state.dart';

class ExpensesBloc extends Bloc<ExpensesBlocEvent, ExpensesBlocState> {
  ExpensesBloc() : super(LoadingExpenses()) {
    final ExpensesServices _service = ExpensesServices();

    List<ExpensesModel> _records = [];
    bool _isEnded = false;
    int _currentPage = 1;

    _clear() {
      _records.clear();
      _currentPage = 1;
      _isEnded = false;
    }

    Future<void> _laodMore() async {
      if (_isEnded) {
        return;
      }

      final List<ExpensesModel> records = await _service.getExpenses(_currentPage++);

      if (records.length < _service.perPage) {
        _isEnded = true;
      }

      _records.addAll(records);
    }

    Future<void> _onLoad(LoadExpenses event, emit) async {
      if (_records.isEmpty) {
        _clear();
        emit(LoadingExpenses());
      }

      if (_isEnded) {
        return;
      }

      await _laodMore();

      emit(GotExpenses(
        expenses: List.from(_records),
        isEnded: _isEnded,
      ));
    }

    Future<void> _onReload(ReloadExpenses event, emit) async {
      _clear();
      emit(LoadingExpenses());

      await _laodMore();

      emit(GotExpenses(
        expenses: List.from(_records),
        isEnded: _isEnded,
      ));
    }

    Future<void> _onAddNewExpense(AddNewExpenses event, emit) async {
      locator<AppDialogs>()
          .showCostumTextLoading(event.context.translate.addin_new_expense);

      await Future.delayed(const Duration(seconds: 1));

      _records.add(event.newExpenses);

      locator<AppDialogs>().disposeAnyActiveDialogs();

      // send snackbar message..
      showSnackBar(
        message: SuccessSnackBar(
          title: event.context.translate.expense_added_successfuly,
          message: "",
        ),
      );

      GoRouter.of(event.context).go(AppRoutes.expensesTracking);

      emit(GotExpenses(
        expenses: List.from(_records),
        isEnded: _isEnded,
      ));
    }
 
    Future<void> _onDeleteExpense(DeleteExpense event, emit) async {
      locator<AppDialogs>()
          .showCostumTextLoading(locator<BuildContext>().translate.deleting);

      await Future.delayed(const Duration(seconds: 1));

      _records.removeWhere((element) => element.id == event.expenseType.id);

      locator<AppDialogs>().disposeAnyActiveDialogs();

      // send snackbar message..
      showSnackBar(
        message: SuccessSnackBar(
          title: locator<BuildContext>().translate.expense_type_deleted_successfully,
          message: "done",
        ),
      );

      emit(GotExpenses(
        expenses: List.from(_records),
        isEnded: _isEnded,
      ));
    }
 

    // even listeners
    on<LoadExpenses>(_onLoad); 
    
    on<ReloadExpenses>(_onReload); 
    
    on<AddNewExpenses>(_onAddNewExpense); 


    on<DeleteExpense>(_onDeleteExpense); 
    


  }
}
