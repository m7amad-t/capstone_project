// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/UI/components/boughtedProductCard.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/logic/buyingProductBloc/buying_product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/logic/models/productBoughtModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/models/productReturnedModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/returnedProductBlocs/blocForOneProduct/returned_product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/returnedProductBlocs/shared/enum.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/components/returnedProductCard.dart';
import 'package:shop_owner/shared/UI/appLoadingCards.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ProductHistorySection extends StatefulWidget {
  final ProductModel product;
  const ProductHistorySection({super.key, required this.product});

  @override
  State<ProductHistorySection> createState() => _ProductHistorySectionState();
}

class _ProductHistorySectionState extends State<ProductHistorySection> {
  final ValueNotifier<DateTimeRange?> _returnedSelectedRange =
      ValueNotifier<DateTimeRange?>(null);
  final ValueNotifier<DateTimeRange?> _boughtedSelectedRange =
      ValueNotifier<DateTimeRange?>(null);

  updateBoughtedSelectedRange(DateTimeRange? newRange) {
    if (_boughtedSelectedRange.value == newRange) {
      return;
    }

    if (newRange != null) {
      _boughtedSelectedRange.value = newRange;
      // fetch data for returned products in the new range
      context.read<BuyingProductBloc>().add(LoadProductBoughtHistoryInRange(
            product: widget.product,
            range: _boughtedSelectedRange.value!,
          ));
    } else {
      _boughtedSelectedRange.value = newRange;
      // fetch data for boughted products : no range
      context.read<BuyingProductBloc>().add(LoadProductBoughtHistory(
            product: widget.product,
          ));
    }
  }

  updateReturnedSelectedRange(DateTimeRange? newRange) {
    if (_returnedSelectedRange.value == newRange) {
      return;
    }

    if (newRange != null) {
      _returnedSelectedRange.value = newRange;
      // fetch data for returned products in the new range
      context.read<ReturnedProductBloc>().add(LoadReturnedProductInRange(
            product: widget.product,
            end: _returnedSelectedRange.value!.end,
            start: _returnedSelectedRange.value!.start,
          ));
    } else {
      _returnedSelectedRange.value = newRange;
      // fetch data for boughted products : no range
      context.read<ReturnedProductBloc>().add(LoadReturnedProduct(
            product: widget.product,
          ));
    }
  }

  Future<void> _onDateRangePicker() async {
    final result = await showAppDateTimeRangePicker(
      context,
      isReturned ? _returnedSelectedRange.value : _boughtedSelectedRange.value,
    );
    if (isReturned) {
      return updateReturnedSelectedRange(result);
    } else {
      return updateBoughtedSelectedRange(result);
    }
  }

  @override
  void initState() {
    super.initState();
    // load returend records for the product
    context.read<ReturnedProductBloc>().add(LoadReturnedProduct(
          product: widget.product,
        ));

    context
        .read<BuyingProductBloc>()
        .add(ReloadProductBoughtHistory(product: widget.product));
  }

  @override
  void dispose() {
    _boughtedSelectedRange.dispose();
    _returnedSelectedRange.dispose();
    super.dispose();
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
                      context.translate.purchase_history,
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

        // button for selecting range
        isReturned
            ? _selectDateRangeButton()
            : _selectDateRangeButtonForBoughted(),

        gap(height: AppSizes.s4),
        _selectedDateRange(),
        if (isReturned) gap(height: AppSizes.s10),
        if (isReturned) _filerSection(),
        // _dateRangePicker(),

        gap(height: AppSizes.s10),
        Container(
          child: isReturned ? _returnedHistory() : _boughtedHistory(),
        ),
      ],
    );
  }

  Widget _selectedDateRange() {
    final textStyle = Theme.of(context).textTheme;

    if (!isReturned) {
      return ValueListenableBuilder<DateTimeRange?>(
        valueListenable: _boughtedSelectedRange,
        builder: (context, value, child) {
          if (value == null) {
            return const SizedBox();
          }
          return Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  context.translate.select_date_range,
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

    return ValueListenableBuilder<DateTimeRange?>(
      valueListenable: _returnedSelectedRange,
      builder: (context, value, child) {
        if (value == null) {
          return const SizedBox();
        }
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                context.translate.select_date_range,
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
    final textStyle = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ValueListenableBuilder(
            valueListenable: _returnedSelectedRange,
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
                    value == null ? context.translate.select_date_range : context.translate.change_selected_date_range,
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

  Widget _selectDateRangeButtonForBoughted() {
    final textStyle = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ValueListenableBuilder(
            valueListenable: _boughtedSelectedRange,
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
                    value == null ? context.translate.select_date_range : context.translate.change_selected_date_range,
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
                            context.translate.all,
                            style: textStyle.bodyMedium,
                          ),
                        ),
                        // return reasons
                        for (final option in RETURN_REASON_LIST)
                          _dropDownItem(option, option.name(context), textStyle),
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
          return RepaintBoundary(
            child: AppLoadingCards(
              height: AppSizes.s200,
              cards: 1,
            ),
          );
        }

        if (state is FailedToLoadProductReturnedRecords) {
          return  Text(context.translate.something_went_wrong);
        }

        List<ProductReturnedModel> records = [];

        if (state is GotReturnedForProduct) {
          records = state.records;
        }

        if (records.isEmpty) {
          return Text(context.translate.no_data_found);
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

  Widget _boughtedHistory() {
    return BlocBuilder<BuyingProductBloc, BuyingProductBlocState>(
      builder: (context, state) {
        if (state is LoadingBoughtForProduct) {
          return RepaintBoundary(
            child: AppLoadingCards(
              height: AppSizes.s200,
            ),
          );
        }

        if (state is FailedToLoadProductBoughtHistory) {
          return Text(context.translate.something_went_wrong);
        }

        List<ProductBoughtModel> records = [];

        if (state is GotProductBoughtHistory) {
          records = state.records;
        }

        if (records.isEmpty) {
          return Text(context.translate.no_data_found);
        }
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: records.length,
          itemBuilder: (context, index) => BoughtedProductCard(
            record: records[index],
          ).paddingSymmetric(
              // horizontal: AppPaddings.p10,
              vertical: AppPaddings.p10),
        );
      },
    );
  }
}
