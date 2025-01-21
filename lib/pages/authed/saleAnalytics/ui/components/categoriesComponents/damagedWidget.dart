import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/categoriesRelated/categoriesDamagedModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/analyticsService.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/categoryLaodingSkeleton.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/chartsConfig.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/noDataCase.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/totalSection.dart';
import 'package:shop_owner/shared/UI/appTablecomponents.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoryDamagedSection extends StatefulWidget {
  const CategoryDamagedSection({
    super.key,
  });

  @override
  State<CategoryDamagedSection> createState() => _CategoryDamagedSectionState();
}

class _CategoryDamagedSectionState extends State<CategoryDamagedSection> {
  final _service = AnalyticsService();

  late CategoriesDamagedModel damagedData;
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
    final res = await _service.getCategoriesDamagedData(
      _selectedDateRange,
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
      return const AnalyticsPagesLoadingSkeleton(
        scrollable: false,
      );
    }

    if (damagedData.categories.isEmpty) {
      return NoDataFoundCase(
          changeDateButton: _changeDateButton(textStyle, context));
    }

    return Column(
      children: [
        // top gap
        gap(height: AppPaddings.p30),
        // drop down menu

        //
        _changeDateButton(textStyle, context),

        gap(height: AppPaddings.p10),

        // piechart ...
        AppChartsConfig.responsivePieChart(
          widget:  SfCircularChart(
                title: AppChartsConfig.dateTtitle(
                  text: "${getAppDate(damagedData.range.start)}    ${context.translate.to}    ${getAppDate(damagedData.range.end)}",
                  textStyle: textStyle,
                ),
                tooltipBehavior: TooltipBehavior(
                  elevation: 5,
                  enable: true,
                  format: "point.y",
                  header: context.translate.total_damaged,
                ),
                series: _buildAreaSeries(context),
              ), 
        ),

        gap(height: AppSizes.s20),
        TotalSection(
          lable: context.translate.total_damaged,
          value: 0,
          primaryValue: damagedData.totalDamaged,
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
        tableKit.column(lable: context.translate.category),
        tableKit.column(lable: context.translate.damaged),
      ],
      rows: [
        for (final row in damagedData.categories)
          tableKit.row(cells: [
            tableKit.cell(text: row.name),
            tableKit.cell(text: row.damaged.toString()),
          ]),
      ],
    ).paddingSymmetric(horizontal: AppPaddings.p10);
  }

  List<CircularSeries<CategoryDamagedModel, String>> _buildAreaSeries(
      BuildContext context) {
    return <CircularSeries<CategoryDamagedModel, String>>[
      PieSeries<CategoryDamagedModel, String>(
        dataSource: damagedData.categories,
        xValueMapper: (CategoryDamagedModel data, int index) => data.name,
        yValueMapper: (CategoryDamagedModel data, int index) => data.damaged,
        dataLabelMapper: (CategoryDamagedModel data, int index) => data.name,
        radius: AppChartsConfig.pieRaduis,
        explode: AppChartsConfig.tapToSlicePie,
        enableTooltip: AppChartsConfig.enableToolTip,
        dataLabelSettings: AppChartsConfig.dataLableSettingForPie,
      ),
    ];
  }
}
