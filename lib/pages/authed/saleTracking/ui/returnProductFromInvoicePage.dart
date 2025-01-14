import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/models/productReturnedModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/returnedProductBlocs/blocForOneProduct/returned_product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/returnedProductsPages/logic/returnedProductBlocs/shared/enum.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/models/invoiceModel.dart';
import 'package:shop_owner/pages/authed/saleTracking/logic/models/productSellModel.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:shop_owner/utils/inputFormater.dart';

class ReturnParoductFromInvoicePage extends StatefulWidget {
  final InvoiceModel invoice;
  const ReturnParoductFromInvoicePage({super.key, required this.invoice});

  @override
  State<ReturnParoductFromInvoicePage> createState() =>
      _ReturnParoductFromInvoicePageState();
}

class _ReturnParoductFromInvoicePageState
    extends State<ReturnParoductFromInvoicePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<RETURN_PRODUCT_REASON?> _returnReason =
      ValueNotifier(null);

  final ValueNotifier<ProductSellModel?> _slectedProduct = ValueNotifier(null);

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
    _quantityController.addListener(_quantityControllerListener);
    _boughtedFor = TextEditingController();

  }

  @override
  void dispose() {
    _quantityController.removeListener(_quantityControllerListener);
    _quantityController.dispose();
    _noteController.dispose();
    _slectedProduct.dispose();
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

  void _onSelectProductChange(ProductSellModel? value) {
    if (value == null) {
      _quantityController.text = '';
    }
    _slectedProduct.value = value;
  }

  void _quantityControllerListener() {
    // if no product is Selected empty the text field
    if (_slectedProduct.value == null) {
      _quantityController.text = '';
      return;
    }

    if (_quantityController.text.isEmpty) {
      return;
    }

    int productQuantity = _slectedProduct.value!.quantity;
    int currentQuantity = int.parse(_quantityController.text);
    if (currentQuantity > productQuantity) {
      _quantityController.text = '$productQuantity';
      return;
    }
  }

  double get _subTotal {
    double sub = 0;
    for (final record in widget.invoice.products) {
      sub += record.quantity * record.product.price;
    }
    return sub;
  }

  void _onReturnProductButton() {
    if (_formKey.currentState!.validate()) {
      // create return model
      final ProductReturnedModel model = ProductReturnedModel(
        id: -1,
        product: _slectedProduct.value!.product,
        refund: double.parse(_refundController.text),
        returnedQuantity: int.parse(_quantityController.text),
        date: DateTime.now(),
        reason: _returnReason.value!,
        note: _noteController.text,
        backToInventory: _returnTOInventory.value!,
        costPerItem: _boughtedFor.text.isEmpty ? null : double.parse(_boughtedFor.text) ,
        invoice: widget.invoice,
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
                  'Product Return Form',
                  style: _textStyle.displayLarge,
                ),
                gap(height: AppSizes.s30),

                // total was section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Invoice Total was',
                      style: _textStyle.displayMedium,
                    ),
                    Text(
                      "\$${widget.invoice.total.toStringAsFixed(2)}",
                      style: _textStyle.displayMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (_subTotal != widget.invoice.total) gap(height: AppSizes.s4),
                // sub total, if there was any discount applyed to the invoice
                if (_subTotal != widget.invoice.total)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SubTotal was',
                        style: _textStyle.displaySmall,
                      ),
                      Text(
                        "\$${_subTotal.toStringAsFixed(2)}",
                        style: _textStyle.displaySmall!.copyWith(
                          // fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),

                gap(height: AppSizes.s10),

                // product return form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                    
                      // selection of the returned product section
                      _productSelectorSection(),
                      gap(height: AppSizes.s4),

                      // total for the selected and sold quantity section
                      ValueListenableBuilder(
                        valueListenable: _slectedProduct,
                        builder: (context, value, child) {
                          if (value == null) return const SizedBox();
                          return Row(
                            children: [
                              Expanded(
                                child: _info(
                                  "Sold Quantity",
                                  "${value.quantity}",
                                  _textStyle,
                                  true,
                                ),
                              ),
                              gap(width: AppSizes.s10),
                              Expanded(
                                child: _info(
                                  "Total would be",
                                  "\$${(value.product.price * value.quantity).toStringAsFixed(2)}",
                                  _textStyle,
                                  false,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      
                      gap(height: AppSizes.s10),
                      // reason of return section
                      _resonSelectorSection(),
                      
                      gap(height: AppSizes.s20),
                      
                      _returnBackToSection(),
                      
                      gap(height: AppSizes.s20),
                      
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
                              return 'Please enter cost of the product';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter valid cost';
                            }
                        
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            AppInputFormatter.price,
                          ],
                          decoration: const InputDecoration(
                            hintText: 'Cost per item',
                          ),
                        ).paddingOnly(bottom: AppPaddings.p10, ); 
                        },
                      ),
                     
                      gap(height: AppSizes.s10),
                      
                      // quantity section of the return quantity section
                      ValueListenableBuilder(
                        valueListenable: _slectedProduct,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value == null ? 0.5 : 1,
                            child: _quantityControllerSection(value != null),
                          );
                        },
                      ),

                      gap(height: AppSizes.s30),

                      // refund text field
                      TextFormField(
                        controller: _refundController,
                        validator: (value) {
                          if (value == null) {
                            return 'Refund amount is required';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter valid refund';
                          }

                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          AppInputFormatter.price,
                        ],
                        decoration: const InputDecoration(
                          hintText: 'Refund',
                        ),
                      ),

                      gap(height: AppSizes.s10),

                      // note text field
                      TextField(
                        controller: _noteController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: 'Note',
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
                        child: const Text(
                          'Return Product',
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

  Widget _info(
    String lable,
    String value,
    TextTheme _textStyle,
    bool isLeading,
  ) {
    return Row(
      mainAxisAlignment:
          isLeading ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Text(
          lable,
          style: _textStyle.displaySmall,
        ),
        gap(width: AppSizes.s10),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: _textStyle.displaySmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
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
                      'Select a Reason',
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
                        return 'Please Select a reason';
                      }
                      return null;
                    },
                    items: [
                      for (final reason in RETURN_REASON_LIST)
                        DropdownMenuItem(
                          value: reason,
                          child: Text(
                            reason.name,
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

  Widget _productSelectorSection() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: locator<DynamicSizes>().p100,
      ),
      child: ValueListenableBuilder(
        valueListenable: _slectedProduct,
        builder: (context, value, child) {
          final TextTheme textStyle = Theme.of(context).textTheme;

          return Row(
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<ProductSellModel?>(
                    hint: Text(
                      'Select a Product',
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
                    value: _slectedProduct.value,
                    validator: (value) {
                      if (value == null) {
                        return 'Select a Product';
                      }
                      return null;
                    },
                    items: [
                      for (final product in widget.invoice.products)
                        DropdownMenuItem(
                          value: product,
                          child: Text(
                            product.product.name,
                            style: textStyle.bodyMedium,
                          ),
                        ),
                    ],
                    onChanged: _onSelectProductChange,
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
                      'Select Product return place',
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
                        return 'Please select product place';
                      }
                      return null;
                    },
                    items: [
                      DropdownMenuItem(
                        value: true,
                        child: Text(
                          'Put back to inventory',
                          style: textStyle.bodyMedium,
                        ),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: Text(
                          'Put to losses',
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

  Widget _quantityControllerSection(bool isEnabled) {
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
                enableFeedback: isEnabled,
                onTap: !isEnabled
                    ? null
                    : () {
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
                    return context.translate.enter_valid_quantity;
                  }
                  if (int.parse(value) < 0) {
                    return context.translate.enter_valid_quantity;
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
                  hintText: 'Retured Quantity',
                ),
              ),
            ),

            // remove button
            Expanded(
              flex: 2,
              child: InkWell(
                enableFeedback: isEnabled,
                onTap: !isEnabled
                    ? null
                    : () {
                        if (int.parse(_quantityController.text) <= 0) {
                          return;
                        }
                        _quantityController.text =
                            (int.parse(_quantityController.text) - 1)
                                .toString();
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
