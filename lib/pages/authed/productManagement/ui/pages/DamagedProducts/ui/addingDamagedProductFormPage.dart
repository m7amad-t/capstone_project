import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/DamagedProducts/logic/damagedproductsBloc/damaged_product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/DamagedProducts/logic/models/DamagedProductsModel.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:shop_owner/utils/inputFormater.dart';

class DamagedProductForm extends StatefulWidget {
  final ProductModel product;
  const DamagedProductForm({super.key, required this.product});

  @override
  State<DamagedProductForm> createState() => _DamagedProductFormState();
}

class _DamagedProductFormState extends State<DamagedProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _quantityController;
  late final TextEditingController _noteController;
  late final TextEditingController _boughtedFor;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController();
    _noteController = TextEditingController();
    _boughtedFor = TextEditingController();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _noteController.dispose();
    _boughtedFor.dispose();

    super.dispose();
  }

  void _onReturnProductButton() {
    if (_formKey.currentState!.validate()) {

      // create return model
      final DamagedProductsModel model = DamagedProductsModel(
        id: -1,
        quantity: int.parse(_quantityController.text),
        boughtedPrice: double.parse(_boughtedFor.text),
        product: widget.product,
        note: _noteController.text,
        dateTime: DateTime.now(),
      );



      context.read<DamagedProductBloc>().add(
            AddProductToDamaged(record: model, context: context)
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppPaddings.p10,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // top gap
                gap(height: AppSizes.s30),

                // title
                Text(
                  context.translate.damaged_product_form,
                  style: textStyle.displayLarge,
                ),
                gap(height: AppSizes.s10),

                Text(
                  "(${widget.product.name})",
                  style: textStyle.displayLarge,
                ),
                gap(height: AppSizes.s30),

                // product return form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // selection of the returned product section

                      gap(height: AppSizes.s10),
                      // reason of return section

                      // product boughted for..
                      TextFormField(
                        controller: _boughtedFor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.translate.please_enter_cost;
                          }
                          if (double.tryParse(value) == null) {
                            return context.translate.please_enter_valid_cost;
                          }

                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          AppInputFormatter.price,
                        ],
                        decoration:  InputDecoration(
                          hintText: context.translate.cost,
                        ),
                      ).paddingOnly(
                        bottom: AppPaddings.p10,
                      ),

                      gap(height: AppSizes.s10),

                      // quantity section of the return quantity section
                      _quantityControllerSection(),

                      gap(height: AppSizes.s30),

                      gap(height: AppSizes.s10),

                      // note text field
                      TextField(
                        controller: _noteController,
                        maxLines: 4,
                        decoration:  InputDecoration(
                          hintText: context.translate.note,
                        ),
                      ),
                    ],
                  ),
                ),

                gap(height: AppSizes.s30),

                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: _onReturnProductButton,
                        child: Text(
                          context.translate.add_to_damaged_inventoy,
                        ),
                      ),
                    ),
                  ],
                ),

                // trailing gap
                gap(height: AppSizes.s150),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _quantityControllerSection() {
    return Builder(
      builder: (context) {
        final textStyle = Theme.of(context).textTheme;
        final bool isLTR = context.fromLTR;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // add button
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  int? curr = int.tryParse(_quantityController.text);
                  _quantityController.text =
                      curr == null ? '1' : (curr + 1).toString();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: AppSizes.s50 - 2,
                  // padding: EdgeInsets.all(AppPaddings.p10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(100),
                    border: Border.all(
                      color: AppColors.primary.withAlpha(100),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(isLTR ? 0 : AppSizes.s8),
                      bottomRight: Radius.circular(isLTR ? 0 : AppSizes.s8),
                      bottomLeft: Radius.circular(!isLTR ? 0 : AppSizes.s8),
                      topLeft: Radius.circular(!isLTR ? 0 : AppSizes.s8),
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    color: AppColors.onPrimary,
                    size: AppSizes.s24,
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 5,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.translate.enter_quantity;
                  }
                  if (int.tryParse(value) == null) {
                    return context.translate.enter_quantity;
                  }
                  if (int.parse(value) <= 0) {
                    return context.translate.please_enter_quantity;
                  }

                  return null;
                },
                textAlign: TextAlign.center,
                controller: _quantityController,
                inputFormatters: [
                  AppInputFormatter.numbersOnly,
                ],
                keyboardType: TextInputType.number,
                style: textStyle.displayMedium,
                decoration: InputDecoration(
                  fillColor: AppColors.primary.withAlpha(100),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primary.withAlpha(100),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primary.withAlpha(100),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  hintText: context.translate.returned_quantity,
                ),
              ),
            ),

            // remove button
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  if (int.parse(_quantityController.text) <= 0) {
                    return;
                  }
                  _quantityController.text =
                      (int.parse(_quantityController.text) - 1).toString();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: AppSizes.s50 - 2,
                  // padding: EdgeInsets.all(AppPaddings.p10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(100),
                    border: Border.all(
                      color: AppColors.primary.withAlpha(100),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(!isLTR ? 0 : AppSizes.s8),
                      bottomRight: Radius.circular(!isLTR ? 0 : AppSizes.s8),
                      bottomLeft: Radius.circular(isLTR ? 0 : AppSizes.s8),
                      topLeft: Radius.circular(isLTR ? 0 : AppSizes.s8),
                    ),
                  ),
                  child: Icon(
                    Icons.remove,
                    color: AppColors.onPrimary,
                    size: AppSizes.s24,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
