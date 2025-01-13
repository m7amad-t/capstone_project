// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/models/productReturnedModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/returnedProductBlocs/blocForOneProduct/returned_product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/returnedProductBlocs/shared/enum.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/components/returnedProductCard.dart';
// import 'package:shop_owner/pages/authed/productManagement/ui/components/returnedProductCard.dart';
// import 'package:shop_owner/pages/authed/productManagement/logic/returnedProductBlocs/shared/enum.dart';
import 'package:shop_owner/shared/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/di/contextDI.dart';

class ProductHistorySection extends StatefulWidget {
  final ProductModel product;
  const ProductHistorySection({super.key, required this.product});

  @override
  State<ProductHistorySection> createState() => _ProductHistorySectionState();
}

class _ProductHistorySectionState extends State<ProductHistorySection> {
  final ValueNotifier<DateTimeRange?> _selectedRange =
      ValueNotifier<DateTimeRange?>(null);

  Future<void> _onDateRangePicker() async {
    _selectedRange.value = await showAppDateTimeRangePicker(
      context,
      _selectedRange.value,
    );

    if (_selectedRange.value != null) {
      context.read<ReturnedProductBloc>().add(LoadReturnedProductInRange(
            product: widget.product,
            start: _selectedRange.value!.start,
            end: _selectedRange.value!.end,
          ));
    }
  }

  @override
  void initState() {
    super.initState();
    // load returend records for the product
    context.read<ReturnedProductBloc>().add(LoadReturnedProduct(
          product: widget.product,
        ));
  }

  bool isReturned = true;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          // padding: EdgeInsets.symmetric(vertical: AppPaddings.p10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.s8),
            color: AppColors.primary.withAlpha(100),
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isReturned = true;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: AppPaddings.p12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppSizes.s8),
                      ),
                      color: isReturned ? AppColors.primary : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Returned Records",
                      style: textStyle.bodyMedium!.copyWith(
                        color: isReturned
                            ? AppColors.onPrimary
                            : AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isReturned = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: AppPaddings.p12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppSizes.s8),
                      ),
                      color: !isReturned ? AppColors.primary : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Bought Records",
                      style: textStyle.bodyMedium!.copyWith(
                        color: !isReturned
                            ? AppColors.onPrimary
                            : AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Divider(height: 0),
        gap(height: AppSizes.s20),

        if (isReturned) _selectDateRangeButton(),
        gap(height: AppSizes.s4),
        _selectedDateRange(),
        if (isReturned) gap(height: AppSizes.s10),
        if (isReturned) _filerSection(),
        // _dateRangePicker(),

        gap(height: AppSizes.s10),
        if (isReturned)
          Container(
            child: isReturned
                ? _returnedHistory()
                : const Text('Not Finished yet '),
          ),
      ],
    );
  }

  Widget _selectedDateRange() {
    if (!isReturned) {
      return const SizedBox();
    }

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

  // filter section (filter by reason)
  Widget _filerSection() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: locator<DynamicSizes>().p100,
      ),
      child: BlocBuilder<ReturnedProductBloc, ReturnedProductBlocState>(
        builder: (context, state) {
          final TextTheme textStyle = Theme.of(context).textTheme;

          RETURN_PRODUCT_REASON? initValue;
          if (state is GotReturnedForProduct) {
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
                        context
                            .read<ReturnedProductBloc>()
                            .add(FilterByReason(reason: value));
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

  Widget _returnedHistory() {
    return BlocBuilder<ReturnedProductBloc, ReturnedProductBlocState>(
      builder: (context, state) {
        if (state is LoadingReturedProduct) {
          return const Center(
            child: RepaintBoundary(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is FailedToLoadProductReturnedRecords) {
          return const Text('Failed to load returned records');
        }

        List<ProductReturnedModel> records = [];

        if (state is GotReturnedForProduct) {
          records = state.records;
        }

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isReturned ? null : 0,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: records.length,
            itemBuilder: (context, index) => ReturnedProductCard(
              record: records[index],
            ).paddingSymmetric(
              horizontal: AppPaddings.p1,
            ),
          ),
        );
      },
    );
  }
}
