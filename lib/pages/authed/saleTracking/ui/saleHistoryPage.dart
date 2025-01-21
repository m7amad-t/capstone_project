// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/models/invoiceModel.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/sellingBloc/selling_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/saleTracking/ui/components/sellingHistorycard.dart';
import 'package:shop_owner/shared/UI/appLoadingCards.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class SaleHistoryPage extends StatefulWidget {
  const SaleHistoryPage({super.key});

  @override
  State<SaleHistoryPage> createState() => _SaleHistoryPageState();
}

class _SaleHistoryPageState extends State<SaleHistoryPage> {
  late final ScrollController _controller;
  final ValueNotifier<DateTimeRange?> _selectedRange =
      ValueNotifier<DateTimeRange?>(null);

  final ValueNotifier<bool> _showScrollToTop = ValueNotifier<bool>(false);


  @override
  void initState() {
    super.initState();
    context.read<SellingBloc>().add(LoadProductSellingRecords());
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    _selectedRange.dispose();
    super.dispose();
  }

  
  void _scrollListener() {
    if (_controller.offset > 550) {
      _showScrollToTop.value = true;
    } else {
      _showScrollToTop.value = false;
    }
  }

  int get _calculateDuration {
    int base = 100;

    base += (_controller.offset * 0.5).toInt();
    return base;
  }

  Widget? _animateToTopButton() {
    return ValueListenableBuilder(
      valueListenable: _showScrollToTop,
      builder: (context, value, child) {
        if (value) {
          return FloatingActionButton(
            onPressed: () {
              _controller.animateTo(
                0,
                duration: Duration(milliseconds: _calculateDuration),
                curve: Curves.linear,
              );
            },
            child: Icon(
              Icons.keyboard_arrow_up_rounded,
              size: AppSizes.s30,
            ),
          );
        }

        return Container();
      },
    );
  }

  Future<void> _onDateRangePicker() async {
    _selectedRange.value = await showAppDateTimeRangePicker(
      context,
      _selectedRange.value,
    );

    if (_selectedRange.value != null) {
      context.read<SellingBloc>().add(
            LoadSellingRecordsInRange(
              start: _selectedRange.value!.start,
              end: _selectedRange.value!.end,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: _animateToTopButton(),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<SellingBloc>().add(ReloadProductSellingRecords());
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPaddings.p10,
          ),
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                gap(height: AppSizes.s30),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ValueListenableBuilder(
                        valueListenable: _selectedRange,
                        builder: (context, value, child) {
                          return InkWell(
                            onTap: _onDateRangePicker,
                            child:  value != null ? AppChangeSelectedDateRangeButtonContent(context)
                    : AppSelectDateRangeButtonContent(context),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                gap(height: 10),
                ValueListenableBuilder(
                  valueListenable: _selectedRange,
                  builder: (context, value, child) {
                    if (value == null) {
                      return const SizedBox();
                    }
                    return Row(
                      children: [
                     
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "${getAppDate(value.start)}     ${context.translate.to}     ${getAppDate(value.end)}",
                            style: textStyle.displaySmall,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Container(
                  child: _historySection(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// todo : start from here


  Widget _historySection() {
    return BlocBuilder<SellingBloc, SellingBlocState>(
      builder: (context, state) {
        if (state is FailedToLoadSellignRecords) {
          return Text(context.translate.something_went_wrong);
        }
        if (state is LoadingProductSellingRecords) {
          return AppLoadingCards(height: AppSizes.s250,  duration: 1200);
        }

        List<InvoiceModel> records = [];

        if (state is GotSellingProductsRecords) {
          records = state.records;
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: records.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => SellingHistoryCard(
            record: records[index],
          )
              .paddingSymmetric(
                vertical: AppSizes.s14,
              )
              .marginOnly(
                bottom: index == records.length - 1 ? AppSizes.s200 : 0,
                top: index == 0 ? AppSizes.s30 : 0,
              ),
        );
      },
    );
  }
}
