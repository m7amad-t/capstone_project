import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/productsRelated/productRevenueModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/analyticsService.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/loadingSkeleton.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/chartsConfig.dart';
import 'package:shop_owner/shared/UI/appTablecomponents.dart';
import 'package:shop_owner/shared/UI/priceWidget.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/monthsEnum.dart';

class ProductRevenueSection extends StatefulWidget {
  final ProductModel product;
  const ProductRevenueSection({super.key, required this.product});

  @override
  State<ProductRevenueSection> createState() => _ProductRevenueSectionState();
}

class _ProductRevenueSectionState extends State<ProductRevenueSection> {
  final _service = AnalyticsService();

  late ProductRevenueModel revenueData;
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

    final res = await _service.getProductRevenue(
      _selectedDateRange,
      widget.product.id,
    );

    if (!mounted) {
      return;
    }

    revenueData = res;
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

    if (revenueData.months.isEmpty) {
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
                "${getAppDate(revenueData.range.start)}    ${context.translate.to}    ${getAppDate(revenueData.range.end)}",
            textStyle: textStyle,
          ),
          primaryXAxis: AppChartsConfig.primaryXAxis,
          tooltipBehavior: AppChartsConfig.toolTipBehavior,
          primaryYAxis: AppChartsConfig.numericAxis(suffix: "K"),
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

  Widget _changeDateButton(TextTheme textStyle, BuildContext contextee) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              final res = await showAppDateTimeRangePicker(
                contextee,
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
        tableKit.column(lable: context.translate.revenue),
      ],
      rows: [
        for (final row in revenueData.months)
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

  List<CartesianSeries<ProductMonthRevenueModel, String>> _buildAreaSeries(
      BuildContext context) {
    return <CartesianSeries<ProductMonthRevenueModel, String>>[
      SplineAreaSeries<ProductMonthRevenueModel, String>(
        dataSource: revenueData.months,
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
