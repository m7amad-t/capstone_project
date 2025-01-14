// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/components/returnedProductCard.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/models/productReturnedModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/returnedProductBlocs/blocForAllProducts/returned_products_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/returnedProductBlocs/shared/enum.dart';
import 'package:shop_owner/shared/UI/appLoadingCards.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/di/contextDI.dart';

class ReturnedProducstHistoryPage extends StatefulWidget {
  const ReturnedProducstHistoryPage({super.key});

  @override
  State<ReturnedProducstHistoryPage> createState() =>
      _ReturnedProducstHistoryPageState();
}

class _ReturnedProducstHistoryPageState
    extends State<ReturnedProducstHistoryPage> {
  late final ValueNotifier<DateTimeRange?> _selectedRange;
  late final ValueNotifier<bool?> _selectedInventory;

  @override
  void initState() {
    super.initState();
    _selectedRange = ValueNotifier<DateTimeRange?>(null);
    _selectedInventory = ValueNotifier<bool?>(null);
    context
        .read<ReturnedProductsBloc>()
        .add(ReloadReturnedRecordsForAll(context: context));
  }

  @override
  void dispose() {
    _selectedRange.dispose();
    _selectedInventory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppPaddings.p10,
          ),
          child: Column(
            children: [
              // top gap
              gap(height: AppSizes.s30),

              // date range selector section
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _selectDateRangeButton(),
                  _selectedDateRange().paddingOnly(top: AppPaddings.p4),
                ],
              ),

              gap(height: AppSizes.s10),
              // date range selector section
              _selectReturnedTo(),

              gap(height: AppSizes.s10),
              // date range selector section
              _filerSection(),

              // gap
              gap(height: AppSizes.s30),

              // result section
              _resultSection(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onDateRangePicker() async {
    _selectedRange.value = await showAppDateTimeRangePicker(
      context,
      _selectedRange.value,
    );

    if (_selectedRange.value != null) {
      context.read<ReturnedProductsBloc>().add(LoadReturnedRecordsForAllInRange(
            context: context,
            start: _selectedRange.value!.start,
            end: _selectedRange.value!.end,
          ));
    }else {
      context.read<ReturnedProductsBloc>().add(ReloadReturnedRecordsForAll(context: context));
    }
  }

  Widget _selectedDateRange() {
    final textStyle = Theme.of(context).textTheme;

    return ValueListenableBuilder<DateTimeRange?>(
      valueListenable: _selectedRange,
      builder: (context, value, child) {
        if (value == null) {
          return const SizedBox();
        }
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Selected Range',
                style: textStyle.displaySmall,
              ),
            ),
            gap(width: AppPaddings.p10),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "${getAppDate(value.start)}     to     ${getAppDate(value.end)}",
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
    final textStyle = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ValueListenableBuilder(
            valueListenable: _selectedRange,
            builder: (context, value, child) {
              return InkWell(
                onTap: _onDateRangePicker,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: AppPaddings.p10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.s8),
                    border: Border.all(color: AppColors.primary),
                    color: value != null
                        ? AppColors.primary.withAlpha(100)
                        : AppColors.primary,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    value == null ? 'Select Range' : 'Change Range',
                    style: textStyle.bodyLarge!.copyWith(
                      color: value == null
                          ? AppColors.onPrimary
                          : AppColors.primary,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _resultSection() {
    return BlocBuilder<ReturnedProductsBloc, ReturnedProductsBlocState>(
      builder: (context, state) {
        final textStyle = TextTheme.of(context);

        print(state);
        if (state is LoadingReturedProducts) {
          return AppLoadingCards(
            height: AppSizes.s180,
          );
        }

        if (state is FailedToLoadProductsReturnedRecords) {
          return Text(
            'Failed to load returned products.',
            style: textStyle.displaySmall,
            textAlign: TextAlign.center,
          );
        }

        List<ProductReturnedModel> records = [];

        if (state is GotReturnedForProducts) {
          records.addAll(state.records);
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: records.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ReturnedProductCard(record: records[index])
                .marginSymmetric(vertical: AppPaddings.p10)
                .paddingOnly(
                  bottom: index == records.length - 1 ? AppSizes.s150 : 0,
                );
          },
        );
      },
    );
  }

  Widget _selectReturnedTo() {
    final textStyle = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ValueListenableBuilder<bool?>(
            valueListenable: _selectedInventory,
            builder: (context, value, child) {
              return DropdownButtonHideUnderline(
                child: DropdownButtonFormField<bool?>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.s8),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: AppSizes.s1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.s8),
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                        )),
                  ),
                  hint: Text(
                    'Select returned place',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  value: _selectedInventory.value,
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(
                        'All',
                        style: textStyle.bodyMedium,
                      ),
                    ),
                    DropdownMenuItem(
                      value: true,
                      child: Text(
                        'Returned To Inventory',
                        style: textStyle.bodyMedium,
                      ),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Text(
                        'Returned To Damaged',
                        style: textStyle.bodyMedium,
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    _selectedInventory.value = value;
                    context.read<ReturnedProductsBloc>().add(
                          FilterByReturnedPlace(
                            context: context,
                            retunedToInvenotory: _selectedInventory.value,
                          ),
                        );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // filter section (filter by reason)
  Widget _filerSection() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: locator<DynamicSizes>().p100,
      ),
      child: BlocBuilder<ReturnedProductsBloc, ReturnedProductsBlocState>(
        builder: (context, state) {
          final TextTheme textStyle = Theme.of(context).textTheme;

          RETURN_PRODUCT_REASON? initValue;
          if (state is GotReturnedForProducts) {
            initValue = state.filter;
          }

          return Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: AppSizes.s6,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.s8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(AppSizes.s8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<RETURN_PRODUCT_REASON?>(
                      value: initValue,
                      // alignment: Alignment.center,
                      items: [
                        //  all option
                        DropdownMenuItem(
                          value: null,
                          child: Text(
                            "All",
                            style: textStyle.bodyMedium,
                          ),
                        ),
                        // return reasons
                        for (final option in RETURN_REASON_LIST)
                          _dropDownItem(option, option.name, textStyle),
                      ],
                      onChanged: (value) {
                        context.read<ReturnedProductsBloc>().add(
                            FilterByReason(context: context, reason: value));
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // drop down menu item template
  DropdownMenuItem<RETURN_PRODUCT_REASON> _dropDownItem(
    RETURN_PRODUCT_REASON? value,
    String text,
    TextTheme textStyle,
  ) {
    return DropdownMenuItem(
      value: value,
      child: Text(
        text,
        style: textStyle.bodyMedium,
      ),
    );
  }
}
