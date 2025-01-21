import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/productsRelated/productTrendModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/analyticsService.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/categoryLaodingSkeleton.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/chartsConfig.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/noDataCase.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/totalSection.dart';
import 'package:shop_owner/shared/UI/appTablecomponents.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TrendingProductsPage extends StatefulWidget {
  const TrendingProductsPage({
    super.key,
  });

  @override
  State<TrendingProductsPage> createState() =>
      _TrendingProductsPageState();
}

class _TrendingProductsPageState extends State<TrendingProductsPage> {
  final _service = AnalyticsService();

  late ProductsTrendModel trendData;
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
    final res = await _service.getTrendCategories(
      _selectedDateRange,
    );

    if (!mounted) {
      return;
    }

    trendData = res;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);

    if (isLoading) {
      return const AnalyticsPagesLoadingSkeleton(
        scrollable: true,
        circle: false,
      );
    }

    if (trendData.categories.isEmpty) {
      return NoDataFoundCase(
          changeDateButton: _changeDateButton(textStyle, context));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          // top gap
          gap(height: AppPaddings.p30),
          // drop down menu
      
          //
          _changeDateButton(textStyle, context),
      
          gap(height: AppPaddings.p10),
          
          SfCartesianChart(
            zoomPanBehavior: AppChartsConfig.zoomBehavior,
                tooltipBehavior: AppChartsConfig.pieToolTipBehavior(format: 'point.y' , header: context.translate.sold_quantity),  
                
                primaryXAxis: AppChartsConfig.primaryXAxisColumn, 
                primaryYAxis: AppChartsConfig.primaryAxisNone, 
                series: _buildAreaSeries(context),
              ), 
              
      
      
          gap(height: AppSizes.s20),
          TotalSection(
            lable: context.translate.sold_quantity,
            value: 0,
            primaryValue: trendData.soldUnites,
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
        tableKit.column(lable: context.translate.product),
        tableKit.column(lable: context.translate.sold_quantity),
      ],
      rows: [
        for (final row in trendData.categories)
          tableKit.row(cells: [
            tableKit.cell(text: row.name),
            tableKit.cell(text: row.soldUnites.toString()),
          ]),
      ],
    ).paddingSymmetric(horizontal: AppPaddings.p10);
  }

  List<ColumnSeries<ProductTreandModel, String>> _buildAreaSeries(
      BuildContext context) {
    return <ColumnSeries<ProductTreandModel, String>>[
      ColumnSeries<ProductTreandModel, String>(
        dataSource: trendData.categories,
        gradient: AppChartsConfig.filledWithPrimaryBTT,
        xValueMapper: (ProductTreandModel data, int index) => data.name,
        yValueMapper: (ProductTreandModel data, int index) => data.soldUnites,
        dataLabelMapper: (ProductTreandModel data, int index) => data.name,
        enableTooltip: AppChartsConfig.enableToolTip,
        color: AppColors.primary,
        // dataLabelSettings: AppChartsConfig.dataLableSettingForPie,
        dataLabelSettings: const DataLabelSettings(
            isVisible: false,
           
            ),
      ),
    ];
  }
}
