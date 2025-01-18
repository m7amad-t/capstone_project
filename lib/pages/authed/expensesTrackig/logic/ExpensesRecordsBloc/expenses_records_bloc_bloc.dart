// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/expensesModel.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/expensesRecords.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/services/expensesRecordsService.dart';
import 'package:shop_owner/shared/UI/appDialogs.dart';
import 'package:shop_owner/shared/UI/uiHelper.dart';
import 'package:shop_owner/shared/models/snackBarMessages.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

part 'expenses_records_bloc_event.dart';
part 'expenses_records_bloc_state.dart';

class ExpensesRecordsBloc
    extends Bloc<ExpensesRecordsBlocEvent, ExpensesRecordsBlocState> {
  ExpensesRecordsBloc() : super(ExpensesRecordsLoading()) {
    final ExpesnesRecordsService service = ExpesnesRecordsService();

    bool isEnded = false;
    ExpensesModel? lastExpenses;
    List<ExpensesRecordsModel> records = [];
    int currentPage = 1;
    DateTimeRange? lastRange;

    clear() {
      isEnded = false;
      lastExpenses = null;
      records = [];
      currentPage = 1;
      lastRange = null;
    }

    Future<void> laodMore() async {
      late final List<ExpensesRecordsModel> res;
      if (lastRange == null) {
        res = await service.getRecords(
          page: currentPage++,
          expenses: lastExpenses!,
        );
      } else {
        res = await service.getRecordsInRange(
          page: currentPage++,
          expenses: lastExpenses!,
          range: lastRange!,
        );
      }

      if (res.length < service.perPage) {
        isEnded = true;
      }

      records.addAll(res);
    }

    Future<void> onLoad(LoadExpenseRecords event, emit) async {
      if (lastExpenses == null || lastRange != null) {
        clear();
        emit(ExpensesRecordsLoading());
        lastExpenses = event.expesnes;
      }

      if (lastExpenses!.id != event.expesnes.id) {
        clear();
        emit(ExpensesRecordsLoading());
      }

      if (isEnded) {
        return;
      }

      lastExpenses = event.expesnes;

      await laodMore();

      emit(GotExpesnsesRecords(
        records: List.from(records),
        lastRange: lastRange,
      ));
    }

    Future<void> onReload(ReloadExpenseRecords event, emit) async {
      final last = lastExpenses;
      clear();
      emit(ExpensesRecordsLoading());

      lastExpenses = last;

      await laodMore();

      emit(GotExpesnsesRecords(
        records: List.from(records),
        lastRange: lastRange,
      ));
    }

    Future<void> onLoadInRange(LoadExpenseRecordsInRange event, emit) async {
      if (lastExpenses == null || lastRange == null) {
        clear();
        emit(ExpensesRecordsLoading());
        lastRange = event.range;
        lastExpenses = event.expesnes;
      }

      if (lastExpenses!.id != event.expesnes.id) {
        clear();
        emit(ExpensesRecordsLoading());
        lastRange = event.range;
        lastExpenses = event.expesnes;
      }

      if (lastRange!.start != event.range.start ||
          lastRange!.start != event.range.start) {
        clear();
        emit(ExpensesRecordsLoading());
        lastRange = event.range;
        lastExpenses = event.expesnes;
      }
      lastRange = event.range;
      lastExpenses = event.expesnes;
      await laodMore();

      emit(GotExpesnsesRecords(
        records: List.from(records),
        lastRange: lastRange,
      ));
    }

    Future<void> onAddRecord(AddRecord event, emit) async {
      if (lastExpenses == null) {
        clear();
        emit(ExpensesRecordsLoading());
      }

      locator<AppDialogs>().showCostumTextLoading(event.context.translate.incurring_expense);
      lastExpenses = event.expesnes;

      final res = await service.AddNewRecord(
        expenses: lastExpenses!,
        record: event.records,
      );

        locator<AppDialogs>().disposeAnyActiveDialogs();


      if (res == false) {
        showSnackBar(
            message:
                FailedSnackBar(title: event.context.translate.failed_to_add_expense_record, message: ""));

        return;
      } else {
        showSnackBar(
            message:
                SuccessSnackBar(title: event.context.translate.expense_added_successfuly, message: ""));
        records.add(event.records);
      }

        GoRouter.of(event.context).pop();
      emit(GotExpesnsesRecords(
        records: List.from(records),
        lastRange: lastRange,
      ));
    }

    Future<void> onDelete(DeleteRecord event, emit) async {
      locator<AppDialogs>().showCostumTextLoading(locator<BuildContext>().translate.deleting);

      lastExpenses = event.expesnes;

      final res = await service.DeleteRecord(
        expenses: lastExpenses!,
        record: event.records,
      );

      locator<AppDialogs>().disposeAnyActiveDialogs();

      if (res == false) {
        showSnackBar(
            message:
                FailedSnackBar(title: locator<BuildContext>().translate.failed_to_delete_expense_record, message: ""));

        return;
      } else {
        showSnackBar(
            message: SuccessSnackBar(
                title: locator<BuildContext>().translate.expense_record_deleted_successfully , message: ""));
        records.removeWhere((element) => element.id == event.records.id); 

      }
      emit(GotExpesnsesRecords(
        records: List.from(records),
        lastRange: lastRange,
      ));
    }

    // event listeners

    on<LoadExpenseRecords>(onLoad);

    on<ReloadExpenseRecords>(onReload);

    on<LoadExpenseRecordsInRange>(onLoadInRange);

    on<AddRecord>(onAddRecord);

    on<DeleteRecord>(onDelete);
  }
}
