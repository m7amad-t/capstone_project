import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/models/productReturnedModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/returnedProductBlocs/blocForOneProduct/returned_product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/returnedProductBlocs/shared/enum.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:shop_owner/utils/inputFormater.dart';

class ReturnProductForm extends StatefulWidget {
  final ProductModel product;
  const ReturnProductForm({super.key, required this.product});

  @override
  State<ReturnProductForm> createState() => _ReturnProductFormState();
}

class _ReturnProductFormState extends State<ReturnProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<RETURN_PRODUCT_REASON?> _returnReason =
      ValueNotifier(null);

  late final TextEditingController _quantityController;
  late final TextEditingController _noteController;
  late final TextEditingController _refundController;
  late final TextEditingController _boughtedFor;

  ValueNotifier<bool?> _returnTOInventory = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController();
    _noteController = TextEditingController();
    _refundController = TextEditingController();
    _boughtedFor = TextEditingController();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _noteController.dispose();
    _returnReason.dispose();
    _boughtedFor.dispose();
    _returnTOInventory.dispose();

    super.dispose();
  }

  void _onChangeForReturnReason(RETURN_PRODUCT_REASON? value) {
    if (value != null) {
      _returnReason.value = value;
    }
  }

  void _onReturnProductButton() {
    if (_formKey.currentState!.validate()) {
      // create return model
      final ProductReturnedModel model = ProductReturnedModel(
        id: -1,
        product: widget.product,
        refund: double.parse(_refundController.text),
        returnedQuantity: int.parse(_quantityController.text),
        date: DateTime.now(),
        reason: _returnReason.value!,
        note: _noteController.text,
        backToInventory: _returnTOInventory.value!,
        costPerItem: _boughtedFor.text.isEmpty ? null : double.parse(_boughtedFor.text) ,
        invoice: null,
      );

      context.read<ReturnedProductBloc>().add(
            ReturnProduct(
              product: model,
              context: context,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _textStyle = Theme.of(context).textTheme;

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
                  context.translate.return_product_form,
                  style: _textStyle.displayLarge,
                ),
                gap(height: AppSizes.s10), 
                    
                Text("(${widget.product.name})", style: _textStyle.displayLarge,), 
                gap(height: AppSizes.s30),

                // product return form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // selection of the returned product section
                      gap(height: AppSizes.s4),

                      gap(height: AppSizes.s10),
                      // reason of return section
                      _resonSelectorSection(),

                      gap(height: AppSizes.s20),

                      _returnBackToSection(),

                      gap(height: AppSizes.s20),

                       // product boughted for..
                      
                      ValueListenableBuilder(
                        valueListenable: _returnTOInventory,
                        builder: (context, isToInventory, child) {
                          if(isToInventory == null || isToInventory == true ){
                            return const SizedBox(); 
                          }
                          return TextFormField(
                          controller: _boughtedFor ,
                          validator: (value) {
                            if(isToInventory == true) {
                                return null; 
                            }
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
                            hintText: context.translate.cost_per_product,
                          ),
                        ).paddingOnly(bottom: AppPaddings.p10, ); 
                        },
                      ),
                      gap(height: AppSizes.s10),

                      // quantity section of the return quantity section
                      _quantityControllerSection(),
                      

                      gap(height: AppSizes.s30),

                     

                      // refund text field
                      TextFormField(
                        controller: _refundController,
                        validator: (value) {
                          if (value == null) {
                            return context.translate.please_enter_refund;
                          }
                          if (double.tryParse(value) == null) {
                            return context.translate.please_enter_valid_refund;
                          }

                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          AppInputFormatter.price,
                        ],
                        decoration:  InputDecoration(
                          hintText: context.translate.refund,
                        ),
                      ),

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
                        child:  Text(
                          context.translate.return_product,
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

  Widget _resonSelectorSection() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: locator<DynamicSizes>().p100,
      ),
      child: ValueListenableBuilder<RETURN_PRODUCT_REASON?>(
        valueListenable: _returnReason,
        builder: (context, value, child) {
          final TextTheme textStyle = Theme.of(context).textTheme;

          return Row(
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<RETURN_PRODUCT_REASON?>(
                    hint: Text(
                      context.translate.select_a_reason,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.s8),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: AppSizes.s1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSizes.s8),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          )),
                    ),
                    value: _returnReason.value,
                    validator: (value) {
                      if (value == null) {
                        return context.translate.select_a_reason;
                      }
                      return null;
                    },
                    items: [
                      for (final reason in RETURN_REASON_LIST)
                        DropdownMenuItem(
                          value: reason,
                          child: Text(
                            reason.name(context),
                            style: textStyle.bodyMedium,
                          ),
                        ),
                    ],
                    onChanged: _onChangeForReturnReason,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _returnBackToSection() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: locator<DynamicSizes>().p100,
      ),
      child: ValueListenableBuilder(
        valueListenable: _returnTOInventory,
        builder: (context, value, child) {
          final TextTheme textStyle = Theme.of(context).textTheme;
          return Row(
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<bool?>(
                    hint: Text(
                      context.translate.select_product,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.s8),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: AppSizes.s1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSizes.s8),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          )),
                    ),
                    value: _returnTOInventory.value,
                    validator: (value) {
                      if (value == null) {
                        return context.translate.please_select_product;
                      }
                      return null;
                    },
                    items: [
                      DropdownMenuItem(
                        value: true,
                        child: Text(
                          context.translate.return_to_inventory,
                          style: textStyle.bodyMedium,
                        ),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: Text(
                          context.translate.return_to_damages_inventory,
                          style: textStyle.bodyMedium,
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      _returnTOInventory.value = value;
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _quantityControllerSection() {
    return Builder(
      builder: (context) {
        final _textStyle = Theme.of(context).textTheme;
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
                      curr == null ? '0' : (curr + 1).toString();
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
                  if (int.parse(value) < 0) {
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
                style: _textStyle.displayMedium,
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
