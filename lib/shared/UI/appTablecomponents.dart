import 'package:flutter/material.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';

class AppDataTableKit {
  final BuildContext context;
  final TextStyle columnTextStyle;
  final TextStyle cellTextStyle;

  AppDataTableKit(
      {required this.context,
      required this.columnTextStyle,
      required this.cellTextStyle});

  Widget table({
    required List<DataColumn> columns,
    required List<DataRow> rows,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double preferedSize = AppSizes.s400;

        if (preferedSize < constraints.maxWidth) {
          preferedSize = constraints.maxWidth;
        }

        return SizedBox(
          width: constraints.maxWidth,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: SizedBox(
              width: preferedSize,
              child: DataTable(
                border: TableBorder.all(color: AppColors.primary),
                columns: columns,
                rows: rows,
              ),
            ),
          ),
        );
      },
    );
  }

  DataCell cell({required String text}) {
    return DataCell(
      Text(
        text,
        style: cellTextStyle,
      ),
    );
  }

  DataCell costumCell({required Widget widget}) {
    return DataCell(
      widget ,
    );
  }

  DataRow row({required List<DataCell> cells}) {
    return DataRow(
      cells: cells,
    );
  }

  DataColumn column({required String lable}) {
    return DataColumn(
      label: Text(
        lable,
        style: columnTextStyle,
      ),
    );
  }
}
