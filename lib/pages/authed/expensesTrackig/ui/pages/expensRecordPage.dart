// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/ExpensesRecordsBloc/expenses_records_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/expensesModel.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/logic/models/expensesRecords.dart';
import 'package:shop_owner/pages/authed/expensesTrackig/ui/components/expensesRecordCard.dart';
import 'package:shop_owner/router/extraTemplates/expensesExtra.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/UI/appLoadingCards.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ExpensesRecordsPage extends StatefulWidget {
  final ExpensesModel expenses;
  const ExpensesRecordsPage({super.key, required this.expenses});

  @override
  State<ExpensesRecordsPage> createState() => _ExpensesRecordsPageState();
}

class _ExpensesRecordsPageState extends State<ExpensesRecordsPage> {
  late final ValueNotifier<DateTimeRange?> _slectedRange;

  Future<void> _onDateRangePicker() async {
    _slectedRange.value = await showAppDateTimeRangePicker(
      context,
      _slectedRange.value,
    );

    if (_slectedRange.value != null) {
      context.read<ExpensesRecordsBloc>().add(LoadExpenseRecordsInRange(
            range: _slectedRange.value!,
            expesnes: widget.expenses,
          ));
    } else {
      context
          .read<ExpensesRecordsBloc>()
          .add(LoadExpenseRecords(expesnes: widget.expenses));
    }
  }

  @override
  void initState() {
    super.initState();
    _slectedRange = ValueNotifier<DateTimeRange?>(null);
    context.read<ExpensesRecordsBloc>().add(LoadExpenseRecords(
          expesnes: widget.expenses,
        ));
  }

  @override
  void dispose() {
    _slectedRange.dispose();
    super.dispose();
  }

  // add floating button
  Widget? _addButton() {
    return BlocBuilder<ExpensesRecordsBloc, ExpensesRecordsBlocState>(
      builder: (context, state) {
        if (state is! GotExpesnsesRecords) {
          return const SizedBox.shrink();
        }

        return FloatingActionButton(
          onPressed: () async {
            // Navigate to add expense screen
            GoRouter.of(context).push(
              "${AppRoutes.expensesTracking}/${AppRoutes.addExpesnesRecord}",
              extra: ExpensExtra(model: widget.expenses).extra,
            );
          },
          child: const  Icon(
            Icons.add,
            size: AppSizes.s30,
            color: AppColors.onPrimary,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _addButton(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10),
        child: Column(
          children: [
            gap(height: AppPaddings.p30),
            _selectDateRangeButton(),
            _selectedDateRange().paddingOnly(top: AppPaddings.p4),
            gap(height: AppPaddings.p10),
            _recordSection(),
          ],
        ),
      ),
    );
  }

  Widget _selectedDateRange() {
    final textStyle = Theme.of(context).textTheme;

    return ValueListenableBuilder<DateTimeRange?>(
      valueListenable: _slectedRange,
      builder: (context, value, child) {
        if (value == null) {
          return const SizedBox();
        }
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                context.translate.select_a_reason,
                style: textStyle.displaySmall,
              ),
            ),
            gap(width: AppPaddings.p10),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "${getAppDate(value.start)}     ${context.translate.to}     ${getAppDate(value.end)}",
                  style: textStyle.displaySmall,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _selectDateRangeButton() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ValueListenableBuilder(
            valueListenable: _slectedRange,
            builder: (context, value, child) {
              return InkWell(
                onTap: _onDateRangePicker,
                child: value != null
                    ? AppChangeSelectedDateRangeButtonContent(context)
                    : AppSelectDateRangeButtonContent(context),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _recordSection() {
    return BlocBuilder<ExpensesRecordsBloc, ExpensesRecordsBlocState>(
      builder: (context, state) {
        if (state is ExpensesRecordsLoading) {
          return const RepaintBoundary(
            child: AppLoadingCards(
              height: AppSizes.s150,
            ),
          );
        }
        if (state is FaieldToLoadExpesesRecords) {
          return Text(context.translate.something_went_wrong);
        }

        List<ExpensesRecordsModel> records = [];

        if (state is GotExpesnsesRecords) {
          records.addAll(state.records);
          _slectedRange.value = state.lastRange;
        }

        if (records.isEmpty) {
          return Text(context.translate.no_data_found);
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: records.length,
          itemBuilder: (context, index) {
            return ExpensesRecordCard(
              record: records[index],
              expense: widget.expenses,
            ).paddingOnly(
              top: index == 0
                  ? AppSizes.s30
                  : AppSizes.s10, // first item has top margin
              bottom: index == records.length - 1 ? AppSizes.s150 : 0,
            );
          },
        );
      },
    );
  }
}
