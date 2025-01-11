import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/models/invoiceModel.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/models/productSellModel.dart';
import 'package:shop_owner/router/extraTemplates/invoiceExtra.dart';
import 'package:shop_owner/router/routes.dart';
import 'package:shop_owner/shared/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/style/theme/appColors.dart';

class SellingHistoryCard extends StatelessWidget {
  final InvoiceModel record;
  final bool isTapable;
  const SellingHistoryCard(
      {super.key, required this.record, this.isTapable = true});

  String trimedName(String name) {
    if (name.length > 15) {
      return name.substring(0, 14);
    }
    return name;
  }

  void _onTapCallback(context) {
    // navigate to return product form invoice
    String path =
        '${AppRoutes.home}/${AppRoutes.saleHistory}/${AppRoutes.returnProductFromInvoice}';
    GoRouter.of(context).push(
      path,
      extra: InvoiceRoutingExtra(invoice: record).extra,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    double subTotal = 0;
    for (final element in record.products) {
      subTotal += element.quantity * element.product.price;
    }

    return Card(
      child: Stack(
        children: [
          InkWell(
            onTap: !isTapable
                ? null
                : () {
                    _onTapCallback(context);
                  },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppPaddings.p10,
                vertical: AppPaddings.p4,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  gap(height: AppPaddings.p20),
                  _dataTable(textStyle),
                  gap(height: AppPaddings.p20),
                  _totalAndTimeSection(subTotal, textStyle),
                  gap(height: AppSizes.s10),
                ],
              ),
            ),
          ),

          // invoice id
          Positioned(
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPaddings.p10,
                    vertical: AppPaddings.p4,
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(100),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(AppSizes.s8),
                        bottomRight: Radius.circular(AppSizes.s8),
                      )),
                  child: Text(
                    "ID ${record.id}",
                    style: textStyle.bodySmall!.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _totalAndTimeSection(double subTotal, TextTheme textStyle) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Total",
                    style: textStyle.bodyMedium!.copyWith(
                        // fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (record.total != subTotal)
                    Opacity(
                      opacity: 0.4,
                      child: Text(
                        "SubTotal",
                        style: textStyle.bodySmall!.copyWith(
                            // decoration: TextDecoration.lineThrough,
                            ),
                      ),
                    ),
                ],
              ),
              gap(width: AppSizes.s10),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "\$${record.total.toStringAsFixed(2)}",
                    style: textStyle.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // gap(width: AppSizes.s6),
                  if (record.total != subTotal)
                    Opacity(
                      opacity: 0.4,
                      child: Text(
                        subTotal.toStringAsFixed(2),
                        style: textStyle.bodySmall!.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Text(
            getAppDateTime(record.time),
          ),
        ),
      ],
    );
  }

  Widget _dataTable(TextTheme textStyle) {
    return DataTable(
      dataRowMinHeight: AppSizes.s40,
      columnSpacing: AppSizes.s30,
      columns: [
        _Column('ID', textStyle),
        _Column('Name', textStyle),
        _Column('Quantity', textStyle),
        _Column('Total', textStyle),
      ],
      rows: [for (final record in record.products) _row(record, textStyle)],
    );
  }

  DataColumn _Column(String lable, TextTheme textStyle) {
    return DataColumn(
      label: Text(
        lable,
        style: textStyle.bodyMedium,
      ),
    );
  }

  DataRow _row(ProductSellModel record, TextTheme textStyle) {
    return DataRow(
      cells: [
        _cell(record.product.id.toString(), textStyle.bodySmall!),
        _cell(trimedName(record.product.name), textStyle.bodySmall!),
        _cell(record.quantity.toString(), textStyle.bodySmall!),
        _cell(
          "\$${(record.product.price * record.quantity).toStringAsFixed(2)}",
          textStyle.bodySmall!,
        ),
      ],
    );
  }

  DataCell _cell(String text, TextStyle textStyle) {
    return DataCell(
      Text(
        text,
        style: textStyle,
      ),
    );
  }
}
