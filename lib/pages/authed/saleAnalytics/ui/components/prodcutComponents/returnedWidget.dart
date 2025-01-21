import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/productsRelated/returnedProductsAnalyticsModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/analyticsService.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/chartsConfig.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/loadingSkeleton.dart';
import 'package:shop_owner/shared/UI/appTablecomponents.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/monthsEnum.dart';

class ProductReturnedSection extends StatefulWidget {
  final ProductModel product;
  const ProductReturnedSection({super.key, required this.product});

  @override
  State<ProductReturnedSection> createState() => _ProductReturnedSectionState();
}

class _ProductReturnedSectionState extends State<ProductReturnedSection> {
  final _service = AnalyticsService();

  late ReturnedProductAnalyticsModel returnedData;
  bool isLoading = true;

  late DateTimeRange _selectedDateRange;
  @override
  void initState() {
    super.initState();
    _selectedDateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 365)),
      end: DateTime.now(),
    );
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loadData() async {

      if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }


    final res = await _service.getProductReturnedData(
      _selectedDateRange,
      widget.product.id,
    );

    if(!mounted){
      return ; 
    }

    returnedData = res;
    setState(() {

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);

    if (isLoading) {
      return const LoadingSkeletonOfAnalyticses(
        scrollable: false,
      );
    }

    if (returnedData.months.isEmpty) {
      return Column(
        children: [
          gap(height: AppPaddings.p30),
          _changeDateButton(textStyle, context),
          gap(height: AppPaddings.p30),
          Text(
            context.translate.no_data_found,
            style: textStyle.displayMedium,
          ),
        ],
      );
    }

    return Column(
      children: [
        // top gap
        gap(height: AppPaddings.p30),
        // drop down menu

        //
        _changeDateButton(textStyle, context),
        SfCartesianChart(
          plotAreaBorderWidth: 0,
          title: AppChartsConfig.dateTtitle(
            text:
                "${getAppDate(returnedData.range.start)}    ${context.translate.to}    ${getAppDate(returnedData.range.end)}",
            textStyle: textStyle,
          ),
          primaryXAxis: AppChartsConfig.primaryXAxis,
          tooltipBehavior: AppChartsConfig.toolTipBehavior,
          primaryYAxis: AppChartsConfig.numericAxis(),
          zoomPanBehavior: AppChartsConfig.zoomBehavior,
          series: _buildAreaSeries(context),
        ),
        gap(height: AppSizes.s20),
        _table(),

        // trailing gap
        gap(height: AppSizes.s150),
      ],
    );
  }

  Widget _changeDateButton(TextTheme textStyle, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              final res = await showAppDateTimeRangePicker(
                context,
                _selectedDateRange,
              );

              if (res != null) {
                if (res.start != _selectedDateRange.start ||
                    res.end != _selectedDateRange.end) {
                  _selectedDateRange = res;
                  _loadData();
                }
              }
            },
            child: AppChangeSelectedDateRangeButtonContent(context),
          ),
        ),
      ],
    ).paddingSymmetric(
      horizontal: AppPaddings.p10,
    );
  }


  Widget _table() {
    // text style
    final textStyle = TextTheme.of(context);

    // data cell style
    final cellTextStyle = textStyle.bodySmall!;

    // column style
    final columnTextStyle = textStyle.bodyMedium!.copyWith(
      fontWeight: FontWeight.bold,
    );

    final AppDataTableKit tableKit = AppDataTableKit(
      cellTextStyle: cellTextStyle,
      columnTextStyle: columnTextStyle,
      context: context,
    );

    return tableKit.table(
      columns: [
        tableKit.column(lable: context.translate.month),
        tableKit.column(lable: context.translate.returned),
      ],
      rows: [
        for (final row in returnedData.months)
          tableKit.row(
            cells: [
              tableKit.cell(
                text: "${row.month.index + 1}   ${row.month.name(context)}",
              ),
              tableKit.cell(
                text: row.returned.toString(),
              ),
            ],
          ),
      ],
    ).paddingSymmetric(horizontal: AppPaddings.p10);
  }


  List<CartesianSeries<ProductMonthReturnedModel, String>> _buildAreaSeries(
      BuildContext context) {
    return <CartesianSeries<ProductMonthReturnedModel, String>>[
      SplineAreaSeries<ProductMonthReturnedModel, String>(
        dataSource: returnedData.months,
        xValueMapper: (data, index) => data.month.name(context),
        yValueMapper: (data, index) => data.returned,
        borderGradient: AppChartsConfig.filledWithPrimary,
        gradient: AppChartsConfig.filledWithPrimary,
        markerSettings: AppChartsConfig.markerSetting,
        name: context.translate.returned,
      ),
    ];
  }
}
