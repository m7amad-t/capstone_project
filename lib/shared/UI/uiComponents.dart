// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, unused_element, file_names

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/di/contextDI.dart';

Widget gap({double width = 0.0, double height = 0.0}) {
  return SizedBox(
    width: width,
    height: height,
  );
}

Color getStockColor(int stok, TextTheme theme) {
  if (stok <= 0) {
    return AppColors.error;
  } else if (stok <= 5) {
    return AppColors.warning;
  } else {
    return theme.bodyLarge!.color!;
  }
}

String trimName(ProductModel product , {int maxLength = 20}) {
  
  String name = product.name;
  // first check if it contains enters
  if (product.name.contains('\n')) {
    name = product.name.split('\n')[0];
  }
  if (name.length > maxLength) {
    return '${name.substring(0, maxLength)}...';
  }
  return name;
}

String trimDescription(ProductModel product , {int maxLength = 50}) {
  String description = product.description;

  // splet lines
  final splet = description.split('\n');

  if (splet.length > 2) {
    description = '${splet[0]}\n${splet[1]}';
  }

  if (description.length > maxLength) {
    return '${description.substring(0, maxLength)}...';
  }
  return description;
}

Widget filterIcon() {
  return Icon(
    Icons.tune_rounded,
    color: AppColors.onPrimary,
    size: AppSizes.s24,
  );
}


Future<DateTimeRange?> showAppDateTimeRangePicker(
  BuildContext context,
  DateTimeRange? current,
) async {
  DateTime? start;
  DateTime? end;
  if (current != null) {
    start = current.start;
    end = current.end;
  }

  final res = await showCalendarDatePicker2Dialog(
    context: context,
    config: CalendarDatePicker2WithActionButtonsConfig(
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      calendarType: CalendarDatePicker2Type.range,
    ),
    value: [start, end],
    dialogSize: Size(
      locator<DynamicSizes>().p90,
      AppSizes.s400,
    ),
  );

  if (res == null) return null;
  if (res.length == 1 && res[0] != null) {
    return DateTimeRange(start: res[0]!, end: res[0]!);
  } else if (res.length == 2 && res[0] != null && res[1] != null) {
    return DateTimeRange(start: res[0]!, end: res[1]!);
  } else {
    return null;
  }
}

Future<DateTime?> showAppDateTimePicker(
  BuildContext context,
  DateTime? current,
) async {
  final res = await showCalendarDatePicker2Dialog(
    context: context,
    config: CalendarDatePicker2WithActionButtonsConfig(
      firstDate: DateTime.now(),
      calendarType: CalendarDatePicker2Type.single,
    ),
    value: [current],
    dialogSize: Size(
      locator<DynamicSizes>().p90,
      AppSizes.s400,
    ),
  );

  if (res == null || res.isEmpty) {
    return null;
  }
  return res[0];
}

// Widget dateRangeSelector(ValueNotifier<DateTimeRange> value, )

