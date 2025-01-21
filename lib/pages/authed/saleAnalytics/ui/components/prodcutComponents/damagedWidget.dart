import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/productsRelated/damagedAnalyticsModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/analyticsService.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/chartsConfig.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/loadingSkeleton.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/noDataCase.dart';
import 'package:shop_owner/shared/UI/appTablecomponents.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/monthsEnum.dart';

class ProductDamagedSection extends StatefulWidget {
  final ProductModel product;
  const ProductDamagedSection({super.key, required this.product});

  @override
  State<ProductDamagedSection> createState() => _ProductDamagedSectionState();
}

class _ProductDamagedSectionState extends State<ProductDamagedSection> {
  final _service = AnalyticsService();

  late DamagedProductAnalyticsModel damagedData;
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

    final res = await _service.getProductDamagedData(
      _selectedDateRange,
      widget.product.id,
    );

    if (!mounted) {
      return;
    }

    damagedData = res;
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

    if (damagedData.months.isEmpty) {
      NoDataFoundCase(
        changeDateButton: _changeDateButton(
          textStyle,
          context,
        ),
      );
    }

    return Column(
      children: [
        // top gap
        gap(height: AppPaddings.p30),
        // drop down menu

        //
        _changeDateButton(textStyle, context),
       
      //  graph
        SfCartesianChart(
          plotAreaBorderWidth: 0,
          title: AppChartsConfig.dateTtitle(
            text:
                "${getAppDate(damagedData.range.start)}    ${context.translate.to}    ${getAppDate(damagedData.range.end)}",
            textStyle: textStyle,
          ),
          primaryXAxis: AppChartsConfig.primaryXAxis,
          tooltipBehavior: AppChartsConfig.toolTipBehavior,
          primaryYAxis: AppChartsConfig.numericAxis(),
          zoomPanBehavior: AppChartsConfig.zoomBehavior,
          series: _buildAreaSeries(context),
        ),


        gap(height: AppSizes.s20),
       
      //  table data 
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
        tableKit.column(lable: context.translate.damaged),
      ],
      rows: [
        for (final row in damagedData.months)
          tableKit.row(
            cells: [
              tableKit.cell(
                text: "${row.month.index + 1}   ${row.month.name(context)}",
              ),
              tableKit.cell(
                text: row.damaged.toString(),
              ),
            ],
          ),
      ],
    ).paddingSymmetric(horizontal: AppPaddings.p10);
  }

  List<CartesianSeries<ProductMonthDamagedModel, String>> _buildAreaSeries(
      BuildContext context) {
    return <CartesianSeries<ProductMonthDamagedModel, String>>[
      SplineAreaSeries<ProductMonthDamagedModel, String>(
        dataSource: damagedData.months,
        xValueMapper: (data, index) => data.month.name(context),
        yValueMapper: (data, index) => data.damaged,
        borderGradient: AppChartsConfig.filledWithPrimary,
        gradient: AppChartsConfig.filledWithPrimary,
        markerSettings: AppChartsConfig.markerSetting,
        name: context.translate.damaged,
      ),
    ];
  }
}
