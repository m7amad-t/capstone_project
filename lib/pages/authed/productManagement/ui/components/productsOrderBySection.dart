import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/bloc/product_bloc_bloc.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class ProductOrderOptionSection extends StatelessWidget {
  const ProductOrderOptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(

      constraints: BoxConstraints(
        maxHeight: AppSizes.s100,
        maxWidth: locator<DynamicSizes>().p100,
      ),
      child: BlocBuilder<ProductBloc, ProductBlocState>(
        builder: (context, state) {
          final TextTheme textStyle = Theme.of(context).textTheme;

          ORDER_PRODUCT_BY initValue = ORDER_PRODUCT_BY.DEFAULT;
          if (state is GotProducts) {
            initValue = state.orderby;
          }

          return Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: AppSizes.s6,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.s8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(AppSizes.s8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<ORDER_PRODUCT_BY>(
                      value: initValue,
                      items: [
                        DropdownMenuItem(
                          value: ORDER_PRODUCT_BY.DEFAULT,
                          child: Text(
                            context.translate.order_by_default,
                            style: textStyle.bodyMedium,
                          ),
                        ),
                        DropdownMenuItem(
                          value: ORDER_PRODUCT_BY.NAME,
                          child: Text(
                            '${context.translate.name} ${context.translate.name_a_to_z}',
                            style: textStyle.bodyMedium,
                          ),
                        ),
                        DropdownMenuItem(
                          value: ORDER_PRODUCT_BY.NAME_DESC,
                          child: Text(
                            '${context.translate.name} ${context.translate.name_z_to_a}',
                            style: textStyle.bodyMedium,
                          ),
                        ),
                        DropdownMenuItem(
                          value: ORDER_PRODUCT_BY.PRICE,
                          child: Text(
                            context.translate.order_by_price,
                            style: textStyle.bodyMedium,
                          ),
                        ),
                        DropdownMenuItem(
                          value: ORDER_PRODUCT_BY.PRICE_DESC,
                          child: Text(
                            '${context.translate.order_by_price} ${context.translate.price_low_to_high}',
                            style: textStyle.bodyMedium,
                          ),
                        ),
                        DropdownMenuItem(
                          value: ORDER_PRODUCT_BY.QUANTITY,
                          child: Text(
                            '${context.translate.quantity} ${context.translate.quantity_high_to_low}',
                            style: textStyle.bodyMedium,
                          ),
                        ),
                        DropdownMenuItem(
                          value: ORDER_PRODUCT_BY.QUANTITY_DESC,
                          child: Text(
                            '${context.translate.quantity} ${context.translate.quantity_low_to_high}',
                            style: textStyle.bodyMedium,
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        context.read<ProductBloc>().add(OrderBy(value));
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
