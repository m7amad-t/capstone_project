import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/revenueModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/analyticsService.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/categoryLaodingSkeleton.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/chartsConfig.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/noDataCase.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/totalSection.dart';
import 'package:shop_owner/shared/UI/appTablecomponents.dart';
import 'package:shop_owner/shared/UI/priceWidget.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/monthsEnum.dart';

class TotalRevenuePage extends StatefulWidget {
  const TotalRevenuePage({super.key});

  @override
  State<TotalRevenuePage> createState() => _TotalRevenuePageState();
}

class _TotalRevenuePageState extends State<TotalRevenuePage> {
  bool _isLoading = true;
  late DateTimeRange _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _selectedDateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 365)),
      end: DateTime.now(),
    );

    _isLoading = true;
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final AnalyticsService _service = AnalyticsService();
  late TotalRevenueModel data;

  // loadFunction
  Future<void> loadData() async {
    setState(() {
      _isLoading = true;
    });

    data = await _service.getTotalRevenue(_selectedDateRange);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);

    if (_isLoading) {
      return const AnalyticsPagesLoadingSkeleton(
        circle: false,
        scrollable: true,
        cardHeight: AppSizes.s200,
      );
    }

    if (data.months.isEmpty) {
      return NoDataFoundCase(
          changeDateButton: _changeDateButton(textStyle, context));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          // top gap
          gap(height: AppPaddings.p30),
          _changeDateButton(textStyle, context),
          SfCartesianChart(
            plotAreaBorderWidth: 0,
            title: AppChartsConfig.dateTtitle(
              text:
                  "${getAppDate(data.range.start)}    ${context.translate.to}    ${getAppDate(data.range.end)}",
              textStyle: textStyle,
            ),
            primaryXAxis: AppChartsConfig.primaryXAxis,
            tooltipBehavior: AppChartsConfig.toolTipBehavior,
            primaryYAxis: AppChartsConfig.numericAxis(suffix: "K"),
            zoomPanBehavior: AppChartsConfig.zoomBehavior,
            series: _buildAreaSeries(context),
          ),
          gap(height: AppSizes.s20),
          TotalSection(
            lable: context.translate.total_revenue,
            value: data.totalRevenue,
          ),
          gap(height: AppSizes.s20),
          _table(),

          // trailing gap
          gap(height: AppSizes.s150),
        ],
      ),
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
                  loadData();
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
        tableKit.column(lable: context.translate.revenue),
      ],
      rows: [
        for (final row in data.months)
          tableKit.row(
            cells: [
              tableKit.cell(
                text: "${row.month.index + 1}   ${row.month.name(context)}",
              ),
              tableKit.costumCell(
                widget: PriceWidget(
                  price: row.revenue,
                  style: tableKit.cellTextStyle,
                ),
              ),
            ],
          ),
      ],
    ).paddingSymmetric(horizontal: AppPaddings.p10);
  }

  List<CartesianSeries<MonthRevenueModel, String>> _buildAreaSeries(
      BuildContext context) {
    return <CartesianSeries<MonthRevenueModel, String>>[
      SplineAreaSeries<MonthRevenueModel, String>(
        dataSource: data.months,
        xValueMapper: (data, index) => data.month.name(context),
        yValueMapper: (data, index) => totalFormatted(data.revenue),
        borderGradient: AppChartsConfig.filledWithPrimary,
        gradient: AppChartsConfig.filledWithPrimary,
        markerSettings: AppChartsConfig.markerSetting,
        name: context.translate.total_revenue,
      ),
    ];
  }

  double totalFormatted(double value) {
    return value / 1000;
  }
}
