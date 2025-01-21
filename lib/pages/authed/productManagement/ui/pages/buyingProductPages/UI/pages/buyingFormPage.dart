import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/enum/enum.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/logic/buyingProductBloc/buying_product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/buyingProductPages/logic/models/productBoughtModel.dart';
import 'package:shop_owner/shared/UI/priceWidget.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/style/dateFormat.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:shop_owner/utils/inputFormater.dart';

class BuyingProductFormPage extends StatefulWidget {
  final ProductModel product;
  const BuyingProductFormPage({super.key, required this.product});

  @override
  State<BuyingProductFormPage> createState() => _BuyingProductFormPageState();
}

class _BuyingProductFormPageState extends State<BuyingProductFormPage> {
  late final TextEditingController _quantity;
  late final TextEditingController _itemInPackageController;
  late final TextEditingController _costController;
  late final TextEditingController _noteController;

  late final ValueNotifier<DateTime?> _expireDate;
  late final ValueNotifier<PURCHASE_UNITE_TYPE?> _selectedPurchaseUnit;
  late final ValueNotifier<COST_UNITE_TYPE?> _selectedCostUnitType;
  late final ValueNotifier<double> _cost; // cost that entered
  late final ValueNotifier<int> _stok; //it might be package or item stok..
  // if user selected package, then it controll number of items in a package
  late final ValueNotifier<int> _itemQuantityInPackage;

  @override
  void initState() {
    super.initState();
    _quantity = TextEditingController()..text = '1';
    _quantity.addListener(() {
      _stok.value = int.tryParse(_quantity.text) ?? 0;
    });
    _noteController = TextEditingController();
    _costController = TextEditingController();
    _costController.addListener(() {
      _cost.value = double.tryParse(_costController.text) ?? 0;
    });
    _itemInPackageController = TextEditingController()..text = '1';
    _itemInPackageController.addListener(() {
      _itemQuantityInPackage.value =
          int.tryParse(_itemInPackageController.text) ?? 0;
    });

    _selectedPurchaseUnit = ValueNotifier(null);
    _expireDate = ValueNotifier(null);
    _selectedCostUnitType = ValueNotifier(null);
    _cost = ValueNotifier(0);
    _stok = ValueNotifier(0);
    _itemQuantityInPackage = ValueNotifier(20);
  }

  @override
  void dispose() {
    _quantity.dispose();
    _noteController.dispose();
    _costController.dispose();
    _itemInPackageController.dispose();
    _expireDate.dispose();
    _selectedPurchaseUnit.dispose();
    _selectedCostUnitType.dispose();
    _stok.dispose();
    _itemQuantityInPackage.dispose();
    super.dispose();
  }

  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10),
            child: _purchaseForm(textStyle),
          ),
        ),
      ),
    );
  }

  Widget _purchaseForm(TextTheme textStyle) {
    return Form(
      key: _formKey,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          // top gap
          gap(height: AppSizes.s30),

          // title of the form
          Text(
            context.translate.buying_product_from,
            style: textStyle.titleMedium,
          ),

          gap(height: AppSizes.s10),

          // product name and selling price
          _productNameAndSellingPrice(),

          gap(height: AppSizes.s40),

          _unitSelector(),

          gap(height: AppSizes.s10),
          _stokInputSection(),
          gap(height: AppSizes.s10),
          _itemQuantityInPackageSection(),
          gap(height: AppSizes.s10),
          _costUnitTypeSelector(),

          gap(height: AppSizes.s10),
          _costInputSection(),

          gap(height: AppSizes.s10),
          _noteInputSection(),

          gap(height: AppSizes.s10),

          _expireDateSelectorSection(),

          gap(height: AppSizes.s40),

          // summary
          _summarySection(),

          _checkOut(),

          gap(height: AppSizes.s150),
        ],
      ),
    );
  }

  Widget _productNameAndSellingPrice() {
    return Builder(builder: (context) {
      final textStyle = TextTheme.of(context);
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "( ${widget.product.name} )",
            style: textStyle.displayLarge,
          ),
        ],
      );
    });
  }

  // selctor of the buying unite (item || package)
  Widget _unitSelector() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: locator<DynamicSizes>().p100,
      ),
      child: ValueListenableBuilder<PURCHASE_UNITE_TYPE?>(
        valueListenable: _selectedPurchaseUnit,
        builder: (context, value, child) {
          final TextTheme textStyle = Theme.of(context).textTheme;

          return Row(
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<PURCHASE_UNITE_TYPE?>(
                    hint: Text(
                      context.translate.select_unit,
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
                    value: _selectedPurchaseUnit.value,
                    validator: (value) {
                      if (value == null) {
                        return context.translate.please_select_unit;
                      }
                      return null;
                    },
                    items: [
                      // item option
                      DropdownMenuItem(
                        value: PURCHASE_UNITE_TYPE.ITEM,
                        child: Text(
                          PURCHASE_UNITE_TYPE.ITEM.name(context),
                          style: textStyle.bodyMedium,
                        ),
                      ),
                      // package option
                      DropdownMenuItem(
                        value: PURCHASE_UNITE_TYPE.PACKAGE,
                        child: Text(
                          PURCHASE_UNITE_TYPE.PACKAGE.name(context),
                          style: textStyle.bodyMedium,
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      _selectedPurchaseUnit.value = value;
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

  // selctor of cost unite type
  Widget _costUnitTypeSelector() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: locator<DynamicSizes>().p100,
      ),
      child: ValueListenableBuilder<PURCHASE_UNITE_TYPE?>(
        valueListenable: _selectedPurchaseUnit,
        builder: (context, value, child) {
          final TextTheme textStyle = Theme.of(context).textTheme;

          return Row(
            children: [
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: _selectedCostUnitType,
                  builder: (context, costUnit, child) {
                    if (costUnit == COST_UNITE_TYPE.PACKAGE &&
                        value != PURCHASE_UNITE_TYPE.PACKAGE) {
                      _selectedCostUnitType.value = COST_UNITE_TYPE.ITEM;
                    }

                    return DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<COST_UNITE_TYPE?>(
                        hint: Text(
                          context.translate.select_cost_type,
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
                            ),
                          ),
                        ),
                        value: _selectedCostUnitType.value,
                        validator: (input) {
                          if (input == null) {
                            return context.translate.select_cost_type;
                          }
                          return null;
                        },
                        items: [
                          // item option
                          DropdownMenuItem(
                            value: COST_UNITE_TYPE.ITEM,
                            child: Text(
                              COST_UNITE_TYPE.ITEM.name(context),
                              style: textStyle.bodyMedium,
                            ),
                          ),

                          // package option
                          DropdownMenuItem(
                            enabled: value == PURCHASE_UNITE_TYPE.PACKAGE,
                            value: COST_UNITE_TYPE.PACKAGE,
                            child: Opacity(
                              opacity: value == PURCHASE_UNITE_TYPE.PACKAGE
                                  ? 1
                                  : 0.4,
                              child: Text(
                                COST_UNITE_TYPE.PACKAGE.name(context),
                                style: textStyle.bodyMedium,
                              ),
                            ),
                          ),
                          // total option
                          DropdownMenuItem(
                            value: COST_UNITE_TYPE.TOTAL,
                            child: Text(
                              COST_UNITE_TYPE.TOTAL.name(context),
                              style: textStyle.bodyMedium,
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          _selectedCostUnitType.value = value;
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // stok input section
  Widget _stokInputSection() {
    return Builder(builder: (context) {
      final textStyle = TextTheme.of(context);
      final isRTL = context.fromLTR;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // quantity controller
          Row(
            children: [
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: AppSizes.s200),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // add button
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            _quantity.text = (int.parse(_quantity.text.isEmpty
                                        ? "0"
                                        : _quantity.text) +
                                    1)
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
                                topRight:
                                    Radius.circular(isRTL ? 0 : AppSizes.s8),
                                bottomRight:
                                    Radius.circular(isRTL ? 0 : AppSizes.s8),
                                bottomLeft:
                                    Radius.circular(!isRTL ? 0 : AppSizes.s8),
                                topLeft:
                                    Radius.circular(!isRTL ? 0 : AppSizes.s8),
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
                              return context.translate.please_enter_quantity;
                            }
                            if (int.parse(value) < 0) {
                              return context
                                  .translate.please_enter_valid_quantity;
                            }

                            return null;
                          },
                          textAlign: TextAlign.center,
                          controller: _quantity,
                          inputFormatters: [
                            AppInputFormatter.numbersOnly,
                          ],
                          keyboardType: TextInputType.number,
                          style: textStyle.bodySmall,
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
                                  width: 2),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            hintText: context.translate.quantity,
                          ),
                        ),
                      ),

                      // remove button
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            if (int.parse(_quantity.text) <= 0) {
                              return;
                            }
                            _quantity.text =
                                (int.parse(_quantity.text) - 1).toString();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: AppSizes.s50 - 2,
                            // padding: EdgeInsets.all(AppPaddings.p10),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withAlpha(100),
                              border: Border.all(
                                  color: AppColors.primary.withAlpha(100),
                                  width: 3),
                              borderRadius: BorderRadius.only(
                                topRight:
                                    Radius.circular(!isRTL ? 0 : AppSizes.s8),
                                bottomRight:
                                    Radius.circular(!isRTL ? 0 : AppSizes.s8),
                                bottomLeft:
                                    Radius.circular(isRTL ? 0 : AppSizes.s8),
                                topLeft:
                                    Radius.circular(isRTL ? 0 : AppSizes.s8),
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
                  ),
                ),
              ),
            ],
          ),

          // lable
          Row(
            children: [
              Opacity(
                opacity: 0.4,
                child: Padding(
                  padding: EdgeInsets.only(top: AppSizes.s1),
                  child: Text(
                    context.translate.quantity,
                    style: textStyle.bodySmall,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  // quantity per package input section
  Widget _itemQuantityInPackageSection() {
    return ValueListenableBuilder(
        valueListenable: _selectedPurchaseUnit,
        builder: (context, value, child) {
          if (value == null || value == PURCHASE_UNITE_TYPE.ITEM) {
            return Container();
          }
          final textStyle = TextTheme.of(context);
          final isRTL = context.fromLTR;
          return Column(
            children: [
              // quantity controller
              Row(
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: AppSizes.s200),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // add button
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {
                                _itemInPackageController
                                    .text = (int.parse(_itemInPackageController
                                                .text.isEmpty
                                            ? "0"
                                            : _itemInPackageController.text) +
                                        1)
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
                                    topRight: Radius.circular(
                                        isRTL ? 0 : AppSizes.s8),
                                    bottomRight: Radius.circular(
                                        isRTL ? 0 : AppSizes.s8),
                                    bottomLeft: Radius.circular(
                                        !isRTL ? 0 : AppSizes.s8),
                                    topLeft: Radius.circular(
                                        !isRTL ? 0 : AppSizes.s8),
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
                                  return context
                                      .translate.please_enter_valid_quantity;
                                }
                                if (int.parse(value) < 0) {
                                  return context
                                      .translate.please_enter_valid_quantity;
                                }

                                return null;
                              },
                              textAlign: TextAlign.center,
                              controller: _itemInPackageController,
                              inputFormatters: [
                                AppInputFormatter.numbersOnly,
                              ],
                              keyboardType: TextInputType.number,
                              style: textStyle.bodySmall,
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
                                      width: 2),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                hintText: context.translate.quantity,
                              ),
                            ),
                          ),

                          // remove button
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {
                                if (int.parse(_itemInPackageController.text) <=
                                    0) {
                                  return;
                                }
                                _itemInPackageController.text =
                                    (int.parse(_itemInPackageController.text) -
                                            1)
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
                                      width: 3),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                        !isRTL ? 0 : AppSizes.s8),
                                    bottomRight: Radius.circular(
                                        !isRTL ? 0 : AppSizes.s8),
                                    bottomLeft: Radius.circular(
                                        isRTL ? 0 : AppSizes.s8),
                                    topLeft: Radius.circular(
                                        isRTL ? 0 : AppSizes.s8),
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
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Opacity(
                    opacity: 0.4,
                    child: Padding(
                      padding: EdgeInsets.only(top: AppSizes.s1),
                      child: Text(
                        context.translate.number_product_per_package,
                        style: textStyle.bodySmall,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  Widget _costInputSection() {
    return Builder(builder: (context) {
      final textStyle = TextTheme.of(context);
      return Row(
        children: [
          Expanded(
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.translate.enter_quantity;
                }
                if (double.tryParse(value) == null) {
                  return context.translate.please_enter_valid_quantity;
                }
                if (double.parse(value) < 0) {
                  return context.translate.please_enter_valid_quantity;
                }

                return null;
              },
              // textAlign: TextAlign.center,
              controller: _costController,
              inputFormatters: [
                AppInputFormatter.price,
              ],

              keyboardType: TextInputType.number,
              style: textStyle.bodySmall,
              decoration: InputDecoration(
                hintText: context.translate.cost,
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _noteInputSection() {
    return Builder(
      builder: (context) {
        final textStyle = TextTheme.of(context);
        return Row(
          children: [
            Expanded(
              child: TextFormField(
                maxLines: 4,
                // textAlign: TextAlign.center,
                controller: _noteController,
                style: textStyle.bodySmall,
                decoration: InputDecoration(
                  hintText: context.translate.note,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _expireDateSelectorSection() {
    return Row(
      children: [
        // expire date  controller
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: _expireDate,
            builder: (context, value, child) {
              final textStyle = TextTheme.of(context);

              return Column(
                children: [
                  InkWell(
                    onTap: () async {
                      _expireDate.value = await showAppDateTimePicker(
                        context,
                        value,
                      );
                    },
                    child: Container(
                      height: AppSizes.s45,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPaddings.p10,
                        vertical: AppPaddings.p4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.s8),
                        color: value == null
                            ? AppColors.primary
                            : AppColors.primary.withAlpha(100),
                        border: Border.all(
                          color: AppColors.primary,
                        ),
                      ),
                      child: ValueListenableBuilder(
                        valueListenable: _expireDate,
                        builder: (context, value, child) {
                          if (value == null) {
                            return Text(
                              context.translate.select_expire_date,
                              style: textStyle.bodyMedium!.copyWith(
                                color: AppColors.onPrimary,
                              ),
                            );
                          }
                          return Text(
                            context.translate.change_expire_date,
                            style: textStyle.bodyMedium!.copyWith(
                              color: AppColors.primary,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  if (value != null)
                    Row(
                      children: [
                        Text(
                          context.translate.selected_date,
                          style: textStyle.displaySmall,
                        ),
                        gap(width: AppSizes.s10),
                        Text(
                          getAppDate(value),
                          style: textStyle.displaySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ).paddingSymmetric(vertical: AppPaddings.p4)
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _summarySection() {
    return ValueListenableBuilder(
      valueListenable: _cost,
      builder: (context, costValue, child) {
        return ValueListenableBuilder(
          valueListenable: _itemQuantityInPackage,
          builder: (context, inPackageValue, child) {
            return ValueListenableBuilder(
              valueListenable: _selectedCostUnitType,
              builder: (context, costTypeValue, child) {
                return ValueListenableBuilder(
                  valueListenable: _selectedPurchaseUnit,
                  builder: (context, uniteTypeValue, child) {
                    return ValueListenableBuilder(
                      valueListenable: _quantity,
                      builder: (context, stok, child) {
                        final textStyle = TextTheme.of(context);
                        return Column(
                          children: [
                            _summary(
                              textStyle,
                              context.translate.total_cost,
                              valueWidget: PriceWidget(
                                price: total,
                                style: textStyle.displayMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              total.toStringAsFixed(2),
                              context.fromLTR,
                            ),
                            gap(height: AppPaddings.p10),
                            if (_selectedPurchaseUnit.value ==
                                PURCHASE_UNITE_TYPE.PACKAGE)
                              _summary(
                                textStyle,
                                context.translate.cost_per_package,
                                valueWidget: PriceWidget(
                                  price: perPackage,
                                  style: textStyle.displayMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                perPackage.toStringAsFixed(2),
                                context.fromLTR,
                              ),
                            if (_selectedPurchaseUnit.value ==
                                PURCHASE_UNITE_TYPE.PACKAGE)
                              gap(height: AppPaddings.p10),
                            _summary(
                              textStyle,
                              context.translate.cost_per_product,
                              valueWidget: PriceWidget(
                                price: perItem,
                                style: textStyle.displayMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              perItem.toStringAsFixed(2),
                              context.fromLTR,
                            ),
                            if (_selectedPurchaseUnit.value ==
                                PURCHASE_UNITE_TYPE.PACKAGE)
                              _summary(
                                textStyle,
                                context.translate.total_products,
                                (_stok.value * _itemQuantityInPackage.value)
                                    .toString(),
                                context.fromLTR,
                              ).paddingOnly(
                                  top: AppPaddings.p10, bottom: AppPaddings.p30)
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _summary(textStyle, String lable, String value, bool isLTR,
      {Widget? valueWidget}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            lable,
            style: textStyle.displayMedium,
          ),
          if (valueWidget != null) valueWidget,
          if (valueWidget == null)
            Text(
              value,
              style: textStyle.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      );

  }

  Widget _checkOut() {
    return Row(
      children: [
        // quantity controller
        Builder(
          builder: (context) {
            final textStyle = TextTheme.of(context);

            return Expanded(
              child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // create a record
                    ProductBoughtModel record = ProductBoughtModel(
                      dateTime: DateTime.now(),
                      pricePerItem: perItem,
                      product: widget.product,
                      quantity: totalItems,
                      expireDate: _expireDate.value,
                      note: _noteController.text,
                    );

                    context
                        .read<BuyingProductBloc>()
                        .add(BoughtProductInSingleProduct(
                          context: context,
                          product: widget.product,
                          record: record,
                        ));
                  }
                },
                child: Text(
                  context.translate.check_out,
                  style: textStyle.bodyMedium!.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  int get totalItems {
    if (_selectedPurchaseUnit.value == PURCHASE_UNITE_TYPE.ITEM) {
      return _stok.value;
    } else if (_selectedPurchaseUnit.value == PURCHASE_UNITE_TYPE.PACKAGE) {
      return _stok.value * _itemQuantityInPackage.value;
    }
    return 0;
  }

  double get total {
    if (_selectedPurchaseUnit.value == PURCHASE_UNITE_TYPE.ITEM) {
      if (_selectedCostUnitType.value == COST_UNITE_TYPE.TOTAL) {
        return _cost.value;
      } else if (_selectedCostUnitType.value == COST_UNITE_TYPE.ITEM) {
        return _cost.value * _stok.value;
      }
    } else if (_selectedPurchaseUnit.value == PURCHASE_UNITE_TYPE.PACKAGE) {
      if (_selectedCostUnitType.value == COST_UNITE_TYPE.TOTAL) {
        return _cost.value;
      } else if (_selectedCostUnitType.value == COST_UNITE_TYPE.ITEM) {
        return _cost.value * _stok.value * _itemQuantityInPackage.value;
      } else if (_selectedCostUnitType.value == COST_UNITE_TYPE.PACKAGE) {
        return _cost.value * _stok.value;
      }
    }
    return 0;
  }

  double get perPackage {
    if (_selectedPurchaseUnit.value == PURCHASE_UNITE_TYPE.ITEM) {
    } else if (_selectedPurchaseUnit.value == PURCHASE_UNITE_TYPE.PACKAGE) {
      if (_selectedCostUnitType.value == COST_UNITE_TYPE.TOTAL) {
        return _cost.value / _stok.value;
      } else if (_selectedCostUnitType.value == COST_UNITE_TYPE.ITEM) {
        return _cost.value * _itemQuantityInPackage.value;
      } else if (_selectedCostUnitType.value == COST_UNITE_TYPE.PACKAGE) {
        return _cost.value;
      }
    }
    return 0;
  }

  double get perItem {
    if (_selectedPurchaseUnit.value == PURCHASE_UNITE_TYPE.ITEM) {
      if (_selectedCostUnitType.value == COST_UNITE_TYPE.TOTAL) {
        return _cost.value / _stok.value;
      } else if (_selectedCostUnitType.value == COST_UNITE_TYPE.ITEM) {
        return _cost.value;
      }
    } else if (_selectedPurchaseUnit.value == PURCHASE_UNITE_TYPE.PACKAGE) {
      if (_selectedCostUnitType.value == COST_UNITE_TYPE.TOTAL) {
        return _cost.value / _stok.value / _itemQuantityInPackage.value;
      } else if (_selectedCostUnitType.value == COST_UNITE_TYPE.ITEM) {
        return _cost.value;
      } else if (_selectedCostUnitType.value == COST_UNITE_TYPE.PACKAGE) {
        return _cost.value / _itemQuantityInPackage.value;
      }
    }
    return 0;
  }
}
