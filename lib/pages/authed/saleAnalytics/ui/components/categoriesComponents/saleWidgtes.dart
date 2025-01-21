import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/models/categoriesRelated/categorySaleModel.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/logic/service/analyticsService.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/categoryLaodingSkeleton.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/chartsConfig.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/noDataCase.dart';
import 'package:shop_owner/pages/authed/saleAnalytics/ui/components/totalSection.dart';
import 'package:shop_owner/shared/UI/appTablecomponents.dart';
import 'package:shop_owner/shared/UI/priceWidget.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/shared/blocs/currencyBloc/currency_bloc_bloc.dart';
import 'package:shop_owner/shared/models/storeCurrency.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/utils/auth/AuthedUser.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategorySaleSection extends StatefulWidget {
  const CategorySaleSection({
    super.key,
  });

  @override
  State<CategorySaleSection> createState() => _CategorySaleSectionState();
}

class _CategorySaleSectionState extends State<CategorySaleSection> {
  final _service = AnalyticsService();

  late CategoriesSaleModel saleData;
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
    final res = await _service.getCategoriesSaleData(
      _selectedDateRange,
    );

    if (!mounted) {
      return;
    }

    saleData = res;
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

    if (saleData.categories.isEmpty) {
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
          widget: BlocBuilder<CurrencyBloc, CurrencyBlocState>(
            builder: (context, state) {
              final String currency = locator<AuthedUser>().currency.sign;
              String title =
                  "${getAppDate(saleData.range.start)}    ${context.translate.to}    ${getAppDate(saleData.range.end)}";
              return SfCircularChart(
                title: AppChartsConfig.dateTtitle(
                  text: title,
                  textStyle: textStyle,
                ),
                tooltipBehavior: TooltipBehavior(
                  elevation: 5,
                  enable: true,
                  format: "${currency}point.y",
                  header: context.translate.total_sale,
                ),
                series: _buildAreaSeries(context),
              );
            },
          ),
        ),

        gap(height: AppSizes.s20),
        TotalSection(lable: context.translate.total_sale, value: saleData.totalSale),  
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
        tableKit.column(lable: context.translate.sale),
      ],
      rows: [
        for (final row in saleData.categories)
          tableKit.row(cells: [
            tableKit.cell(text: row.name),
            tableKit.costumCell(
              widget: PriceWidget(
                price: row.sale,
                style: tableKit.cellTextStyle,
              ),
            ),
          ]),
      ],
    ).paddingSymmetric(horizontal: AppPaddings.p10);
  }

  List<CircularSeries<CategorySaleModel, String>> _buildAreaSeries(
      BuildContext context) {
    return <CircularSeries<CategorySaleModel, String>>[
      PieSeries<CategorySaleModel, String>(
        dataSource: saleData.categories,
        xValueMapper: (CategorySaleModel data, int index) => data.name,
        yValueMapper: (CategorySaleModel data, int index) => data.sale,
        dataLabelMapper: (CategorySaleModel data, int index) => data.name,
        radius: AppChartsConfig.pieRaduis,
        explode: AppChartsConfig.tapToSlicePie,
        enableTooltip: AppChartsConfig.enableToolTip,
        dataLabelSettings: AppChartsConfig.dataLableSettingForPie,
      ),
    ];
  }
}
