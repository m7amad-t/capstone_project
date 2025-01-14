// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/UI/components/boughtedProductCard.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/logic/buyingProductsBloc/buying_products_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/logic/models/productBoughtModel.dart';
import 'package:shop_owner/shared/UI/appLoadingCards.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/style/theme/appColors.dart';

class Boughtedproducts extends StatefulWidget {
  const Boughtedproducts({super.key});

  @override
  State<Boughtedproducts> createState() => _BoughtedproductsState();
}

class _BoughtedproductsState extends State<Boughtedproducts> {
  late final ValueNotifier<DateTimeRange?> _dateRange;
  late final ScrollController _scrollController;
  late final ValueNotifier<bool> _showFloatingButton;

  void _scrollListener() {
    if (_scrollController.offset > 1200) {
      _showFloatingButton.value = true;
    } else {
      _showFloatingButton.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _showFloatingButton = ValueNotifier(false);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    context.read<BuyingProductsBloc>().add(ReloadBoughtHistory());
    _dateRange = ValueNotifier(null);
  }

  @override
  void dispose() {
    _showFloatingButton.dispose();
    _scrollController.dispose();
    _scrollController.removeListener(_scrollListener);
    _dateRange.dispose();
    super.dispose();
  }

  Future<void> _onDateTimeRangePicker() async {
    final res = await showAppDateTimeRangePicker(context, _dateRange.value);

    if (res == null) {
      // check if already is null
      if (_dateRange.value == null) return;

      // update the value
      _dateRange.value = res;
      context.read<BuyingProductsBloc>().add(ReloadBoughtHistory());
    } else {
      if (_dateRange.value == null) {
        _dateRange.value = res;
        context
            .read<BuyingProductsBloc>()
            .add(LoadBoughtHistoryInRange(range: _dateRange.value!));
      }

      if (_dateRange.value!.end == res.end &&
          _dateRange.value!.start == res.start) return;

      _dateRange.value = res;
      context
          .read<BuyingProductsBloc>()
          .add(LoadBoughtHistoryInRange(range: _dateRange.value!));
    }
  }

  int get _caluclateDuration {
    int base = 400;

    return base += (_scrollController.offset * 0.5).toInt();
  }

  Widget _floatingActionButton() {
    return ValueListenableBuilder(
      valueListenable: _showFloatingButton,
      builder: (context, value, child) {
        if (!value) return const SizedBox();

        return FloatingActionButton(
          onPressed: () {
            _scrollController.animateTo(
              0,
              duration: Duration(milliseconds: _caluclateDuration),
              curve: Curves.linear,
            );
          },
          child: Icon(
            Icons.keyboard_arrow_up_rounded,
            size: AppSizes.s30,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);

    return Scaffold(
     
      floatingActionButton: _floatingActionButton(),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<BuyingProductsBloc>().add(ReloadBoughtHistory());
          _dateRange.value = null; 
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(
            horizontal: AppPaddings.p10,
          ),
          child: Column(
            children: [
              // top gap
              gap(height: AppSizes.s30),

              ValueListenableBuilder(
                valueListenable: _dateRange,
                builder: (context, value, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: _onDateTimeRangePicker,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: AppPaddings.p10),
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
                      ),
                      if (value != null) gap(height: AppSizes.s4),
                      if (value != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Opacity(
                              opacity: 0.5,
                              child: Row(
                                children: [
                                  Text(
                                      getAppDate(value.start) , 
                                      textDirection: TextDirection.rtl,
                                      ),
                                      gap(width: AppPaddings.p10),
                                  const Text(
                                      "to" , 
                                      textDirection: TextDirection.rtl,
                                      ),
                                      gap(width: AppPaddings.p10),

                                  Text(
                                      getAppDate(value.end) , 
                                      textDirection: TextDirection.rtl,
                                      ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  );
                },
              ),

              gap(height: AppSizes.s30),
              _historySection()
            ],
          ),
        ),
      ),
    );
  }

  Widget _historySection() {
    return BlocBuilder<BuyingProductsBloc, BuyingProductsBlocState>(
      builder: (context, state) {
        if (state is LoadingBoughtForProducts) {
          return AppLoadingCards(height: AppSizes.s200, duration: 1200);
        }

        List<ProductBoughtModel> records = [];

        if (state is GotProductsBoughtHistory) {
          if (state.range != null) {
            _dateRange.value = state.range;
          }

          records = state.records;
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: records.length,
          itemBuilder: (context, index) {
            return BoughtedProductCard(record: records[index]).marginOnly(
              top: index == 0 ? AppSizes.s30 : 0,
              bottom:
                  index == records.length - 1 ? AppSizes.s150 : AppSizes.s10,
            );
          },
        );
      },
    );
  }
}
