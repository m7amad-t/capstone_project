import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/cartBloc/cart_bloc_bloc.dart';
import 'package:shop_owner/shared/UI/priceWidget.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class CheckoutPage extends StatefulWidget {
  final double discount;
  const CheckoutPage({super.key, required this.discount});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late final TransformationController _transformationController;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _transformationController.value = Matrix4.diagonal3Values(0.7, 0.7, 1.0);
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return BlocBuilder<CartBloc, CartBlocState>(
      builder: (context, state) {
        final rows = state.cartData;

        double total = 0;
        double subTotal = 0;
        for (var item in rows) {
          subTotal += item.quantity * item.product.price;
        }

        total = subTotal - (widget.discount);
        if (total < 0) {
          total = 0;
        }

        bool isDiscounted = widget.discount > 0;

        return Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    child: InteractiveViewer(
                      transformationController: _transformationController,
                      boundaryMargin: const EdgeInsets.all(double.infinity),
                      child: Column(
                        children: [
                          DataTable(
                            columns: [
                              _getColumn(context.translate.id, context),
                              _getColumn(context.translate.name, context),
                              _getColumn(context.translate.quantity, context),
                              _getColumn(context.translate.price, context),
                              _getColumn(context.translate.total, context),
                            ],
                            rows: [
                              for (final row in rows)
                                DataRow(
                                  cells: [
                                    cellData(
                                      row.product.id.toString(),
                                      textStyle,
                                    ),
                                    cellData(
                                      row.product.name,
                                      textStyle,
                                    ),
                                    cellData(
                                      row.quantity.toString(),
                                      textStyle,
                                    ),
                                    cellData(
                                      row.product.price.toStringAsFixed(2),
                                      textStyle,
                                    ),
                                    cellData(
                                      (row.product.price * row.quantity)
                                          .toStringAsFixed(2),
                                      textStyle,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // cart information
            Positioned(
              bottom: AppPaddings.p6,
              left: AppPaddings.p14,
              right: AppPaddings.p14,
              height: AppSizes.s150,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.s8),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: Container(
                        color: AppColors.primary.withAlpha(30),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPaddings.p18,
                      vertical: AppPaddings.p10,
                    ),
                    decoration: BoxDecoration(
                      backgroundBlendMode: BlendMode.color,
                      color: AppColors.primary.withAlpha(30),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          AppSizes.s8,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  context.translate.total,
                                  style: textStyle.displayLarge,
                                ),
                              ),
                              Expanded(
                                child: PriceWidget(price: total, style:  textStyle.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),), 
                                
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  context.translate.sub_total,
                                  style: textStyle.displaySmall,
                                ),
                              ),
                              Expanded(
                                child: Opacity(
                                  opacity: isDiscounted ? 0.5 : 1,
                                  child: PriceWidget(price: subTotal, style:  textStyle.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      decoration: isDiscounted
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ), ), 
                                  
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      // todo : send the event to cart bloc to make the transaction
                                      context
                                          .read<CartBloc>()
                                          .add(PlaceOrder(context: context));
                                    },
                                    child: Text(
                                      context.translate.confirm_payment,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  DataColumn _getColumn(String lable, BuildContext context) {
    return DataColumn(
      label: Text(
        lable,
        style: TextTheme.of(context).bodyMedium,
      ),
    );
  }

  DataCell cellData(String text, TextTheme textStyle) {
    return DataCell(
      Text(
        text,
        style: textStyle.bodySmall,
      ),
    );
  }
}
