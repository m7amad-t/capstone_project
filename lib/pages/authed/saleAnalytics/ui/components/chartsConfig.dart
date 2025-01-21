import 'package:flutter/material.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AppChartsConfig {
  static ChartAxis get primaryXAxis => const CategoryAxis(
        labelPlacement: LabelPlacement.onTicks,
        labelRotation: 45,
        edgeLabelPlacement: EdgeLabelPlacement.none,
        majorGridLines: MajorGridLines(width: 0),
      );

  static ChartAxis get primaryXAxisColumn => const CategoryAxis(
        labelAlignment: LabelAlignment.end,
        labelIntersectAction: AxisLabelIntersectAction.rotate90,
        labelPlacement: LabelPlacement.betweenTicks,
        labelPosition: ChartDataLabelPosition.inside,
        // autoScrollingDelta: 5,
      );

  static ChartAxis get primaryAxisNone => const CategoryAxis(
        isVisible: false,
      );

  static TooltipBehavior get toolTipBehavior => TooltipBehavior(
        enable: true,
        canShowMarker: false,
      );

  static ChartTitle dateTtitle(
          {required TextTheme textStyle, required String text}) =>
      ChartTitle(textStyle: textStyle.displaySmall, text: text);

  static ZoomPanBehavior get zoomBehavior => ZoomPanBehavior(
        enableDoubleTapZooming: true, //double tap to zoom in
        zoomMode: ZoomMode.xy, // axis of zooming
        enablePanning: true, // moving
        enablePinching: true, // zomming with two fingers
      );

  static ChartAxis numericAxis({String suffix = "", String preffix = ""}) =>
      NumericAxis(
        labelFormat: '$preffix{value}$suffix',
        axisLine: const AxisLine(width: 1),
        majorTickLines: const MajorTickLines(size: AppSizes.s2),
      );

  static LinearGradient get filledWithPrimary => LinearGradient(
        colors: <Color>[
          AppColors.primary.withAlpha(100),
          AppColors.primary.withAlpha(200),
          AppColors.primary.withAlpha(255),
        ],
      );

  static LinearGradient get filledWithPrimaryBTT =>
      LinearGradient(colors: <Color>[
        AppColors.primary.withAlpha(100),
        AppColors.primary.withAlpha(200),
        AppColors.primary.withAlpha(255),
      ], begin: Alignment.bottomCenter, end: Alignment.topCenter);
  static LinearGradient costumFilled(Color color) => LinearGradient(
        colors: <Color>[
          color.withAlpha(100),
          color.withAlpha(200),
          color.withAlpha(255),
        ],
      );

  static MarkerSettings get markerSetting => const MarkerSettings(
        isVisible: true,
        color: AppColors.onPrimary,
      );

  static DataLabelSettings get dataLableSettingForPie =>
      const DataLabelSettings(
        useSeriesColor: true,
        labelIntersectAction: LabelIntersectAction.shift,
        labelPosition: ChartDataLabelPosition.outside,
        angle: 0,
        showZeroValue: false,
        borderRadius: AppSizes.s4,
        isVisible: true,
        connectorLineSettings: ConnectorLineSettings(
          type: ConnectorType.curve,
        ),
      );

  static String get pieRaduis => "80%";

  static bool get tapToSlicePie => true;

  static bool get enableToolTip => true;

  static TooltipBehavior pieToolTipBehavior(
          {String format = "point.y", required String header}) =>
      TooltipBehavior(
        elevation: 5,
        enable: true,
        format: format,
        header: header,
      );

  static Widget responsivePieChart({required Widget widget}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double preferedSize = AppSizes.s600;
        double maxPrefered = AppSizes.s600;
        if (constraints.maxWidth > preferedSize) {
          preferedSize = constraints.maxWidth;
        }

        if (preferedSize > maxPrefered) {
          preferedSize = maxPrefered;
        }

        return SizedBox(
          width: constraints.maxWidth > maxPrefered
              ? maxPrefered
              : constraints.maxWidth,
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              height: preferedSize - AppSizes.s200,
              width: preferedSize,
              child: widget,
            ),
          ),
        );
      },
    );
  }
}
