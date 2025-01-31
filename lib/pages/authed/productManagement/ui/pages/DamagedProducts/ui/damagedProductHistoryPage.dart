import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/DamagedProducts/logic/damagedproductsBloc/damaged_product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/DamagedProducts/logic/models/DamagedProductsModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/DamagedProducts/ui/components/damagedProductCard.dart';
import 'package:shop_owner/shared/UI/appLoadingCards.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class DamagedProductsHistoryPage extends StatefulWidget {
  const DamagedProductsHistoryPage({super.key});

  @override
  State<DamagedProductsHistoryPage> createState() =>
      _DamagedProductsHistoryPageState();
}

class _DamagedProductsHistoryPageState
    extends State<DamagedProductsHistoryPage> {
  late final ValueNotifier<DateTimeRange?> _slectedRange;
  late final ValueNotifier<bool> _showScrollToTop;
  bool _ended = false;
  late final ScrollController _scrollController;
  bool isLoadingMore = false;

  // void _scrollListener() {
  //   if(!mounted){
  //     print('its not mounted '); 
  //   }
  //   // showing floating button section
  //   if (_scrollController.offset > 550) {
  //     _showScrollToTop.value = true;
  //   } else {
  //     _showScrollToTop.value = false;
  //   }

  //   print("LOG : ScrollListener"); 

  //   if (_ended) {
  //     return;
  //   }

  //   if (isLoadingMore) {
  //     return;
  //   }

  //   // if its in on loading state or error state done ask for next page..
  //   if (context.read<DamagedProductBloc>().state is! GotDamagedProducts) {
  //     return;
  //   }
  //   final double max = _scrollController.position.maxScrollExtent;

  //   // pagination section
  //   if (max - 400 < _scrollController.offset) {
  //     isLoadingMore = true;
  //     if (_slectedRange.value != null) {
  //       context
  //           .read<DamagedProductBloc>()
  //           .add(LoadDamagedProductInRange(range: _slectedRange.value!));
  //     } else {
  //       context.read<DamagedProductBloc>().add(LoadDamagedProducts());
  //     }
  //   }
  // }

  int get _calculateDuration {
    int base = 100;

    base += (_scrollController.offset * 0.5).toInt();
    return base;
  }

  Widget? _animateToTopButton() {
    return ValueListenableBuilder(
      valueListenable: _showScrollToTop,
      builder: (context, value, child) {
        if (value) {
          return FloatingActionButton(
            onPressed: () {
              _scrollController.animateTo(
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
    _slectedRange.value = await showAppDateTimeRangePicker(
      context,
      _slectedRange.value,
    );

    if (_slectedRange.value != null) {
      context.read<DamagedProductBloc>().add(LoadDamagedProductInRange(
            range: _slectedRange.value!,
          ));
    } else {
      context.read<DamagedProductBloc>().add(ReloadDamaegdProducts());
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // _scrollController.addListener(_scrollListener);
    _slectedRange = ValueNotifier(null);
    _showScrollToTop = ValueNotifier(false);
    context.read<DamagedProductBloc>().add(LoadDamagedProducts());
  }

  @override
  void dispose() {
    // _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _slectedRange.dispose();
    _showScrollToTop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<DamagedProductBloc>().add(ReloadDamaegdProducts());
        // return Future.value();
      },
      child: Scaffold(
        floatingActionButton: _animateToTopButton(),
        body: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10),
          child: Column(
            children: [
              // top gap :
              gap(height: AppPaddings.p30),

              // date range selector section
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _selectDateRangeButton(),
                  _selectedDateRange().paddingOnly(top: AppPaddings.p4),
                ],
              ),

              gap(height: AppSizes.s40),

              _resultSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _resultSection() {
    return BlocBuilder<DamagedProductBloc, DamagedProductBlocState>(
      builder: (context, state) {
        final textStyle = TextTheme.of(context);
        if (state is LoadingDamagedProducts) {
          return const  AppLoadingCards(height: AppSizes.s180);
        }

        if (state is FailedToLoadDamagedProducts) {
          return Text(
            context.translate.something_went_wrong,
            style: textStyle.displayMedium,
            textAlign: TextAlign.center,
          );
        }

        List<DamagedProductsModel> records = [];
        if (state is GotDamagedProducts) {
          records.addAll(state.records);
          _ended = state.isEnded;
          _slectedRange.value = state.lastRange;
        }

        isLoadingMore = false;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: records.length ,
          itemBuilder: (context, index) {
            
            // if (index == records.length ) {


            //   if (_ended) {
            //     // trailing gap
            //     return SizedBox(height: AppSizes.s100);
            //   }
            //   return Shimmer.fromColors(
            //     baseColor: Theme.of(context).scaffoldBackgroundColor,
            //     highlightColor:
            //         Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(20),
            //     loop: 30,
            //     period: const Duration(milliseconds: 1000),
            //     child: SizedBox(
            //       height: AppSizes.s180,
            //       child: const Card(),
            //     ),
            //   ).paddingOnly(top: AppPaddings.p10);
            // }
            
            
            return DamagedProductCard(
              record: records[index],
            ).marginOnly(
              top: AppPaddings.p10,
            );
          },
        );
      },
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
            
            // gap(width: AppPaddings.p10),
            Text(
              "${getAppDate(value.start)}     ${context.translate.to}     ${getAppDate(value.end)}",
              style: textStyle.displaySmall,
            ),
          ],
        );
      },
    );
  }

  // Widget _test (){
  //   return PagedListView
  // }

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
                child: value != null ? AppChangeSelectedDateRangeButtonContent(context)
                    : AppSelectDateRangeButtonContent(context),
              );
            },
          ),
        ),
      ],
    );
  }


}
