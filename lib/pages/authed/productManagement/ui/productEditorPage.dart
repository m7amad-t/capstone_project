import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productCategoryModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/shared/assetPaths.dart';
import 'package:shop_owner/shared/imageDisplayer.dart';
import 'package:shop_owner/shared/models/snackBarMessages.dart';
import 'package:shop_owner/shared/uiComponents.dart';
import 'package:shop_owner/shared/uiHelper.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:shop_owner/utils/inputFormater.dart';
import 'package:toastification/toastification.dart';

class ProductEditorPage extends StatefulWidget {
  final ProductModel? product;
  final List<ProductCategoryModel> categories;
  const ProductEditorPage({
    super.key,
    required this.product,
    required this.categories,
  });

  @override
  State<ProductEditorPage> createState() => _ProductEditorPageState();
}

class _ProductEditorPageState extends State<ProductEditorPage> {
  late ProductModel product;

  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descController;
  late TextEditingController _quantityController;

  ProductCategoryModel? _selectedCategory;

  // product from key
  late final GlobalKey<FormState> _fromKey;

  late final bool _isUpdating;
  @override
  void initState() {
    super.initState();
    _fromKey = GlobalKey<FormState>();
    _isUpdating = widget.product != null;
    product = widget.product ??
        const ProductModel(
            name: "", price: 0, imageUrl: '', description: '', quantity: 0);
    _selectedCategory = widget.categories.first;
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _descController = TextEditingController();
    _quantityController = TextEditingController();

    if (widget.product != null) {
      _nameController.text = product.name;
      _quantityController.text = product.quantity.toString();
      _priceController.text = product.price.toString();
      _descController.text = product.description;
    }
  }

  Uint8List? _newImage;

  Future<void> _saveB_callback() async {
    print("callback ");
    if (!_fromKey.currentState!.validate()) {
      print("from is not validate");
      return;
    }
    // todo : collect values
    // todo : FOR the UI part just relaod products , or update the existing one, one ensert new one

    // if product is not provided then create new one , else update the one how provided,

    String loadingDialog =
        _isUpdating ? context.translate.updating : context.translate.uploading;
    // for now just show a laoding , and then send a snackbar message
    showLoadingDialog(
      context,
      "$loadingDialog ${context.translate.product}",
    );

    // wait for one second
    await Future.delayed(const Duration(seconds: 1));
    // pop loading dialog
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    // navigate back to product management screen
    // pop loading dialog
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    // snackbar title
    String title = _isUpdating
        ? context.translate.product_updated_successfuly
        : context.translate.inserted_successfuly;
    String message = _isUpdating
        ? context.translate.product_updated_successfuly
        : context.translate.inserted_successfuly;
    showSnackBar(
      message: SuccessSnackBar(
        title: title,
        message: message,
      ),
    );
  }
  
  Future<void> _deleteB_callback() async {
   
    await showDeleteProductConfirmation (
      context,
      product,
      
    );

    // wait for one second
    await Future.delayed(const Duration(seconds: 1));
    // // pop loading dialog
    // if (Navigator.of(context).canPop()) {
    //   Navigator.of(context).pop();
    // }

  }


  @override
  Widget build(BuildContext context) {
    final _textStyle = Theme.of(context).textTheme;
    final isRTL = context.fromLTR;
    final String suffix =
        _isUpdating ? context.translate.edit : context.translate.add;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // ignore: prefer_interpolation_to_compose_strings
          suffix + " " + context.translate.product,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // unfocus any focused element
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              // top section , background image and avatar
              _topSecton(),

              gap(height: AppSizes.s20),

              // controllers section
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.s10),
                child: _bodySection(isRTL, _textStyle),
              ),

              // trailling gap
              SizedBox(height: AppSizes.s200),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTheImage() {
    if (_newImage != null) {
      return Image.memory(_newImage!, fit: BoxFit.cover);
    } else if (widget.product == null) {
      return Image.asset(
        AssetPaths.selectImage,
        fit: BoxFit.cover,
      );
    } else {
      return ImageDisplayerWithPlaceHolder(imageUrl: product.imageUrl);
    }
  }

  // top section avatar..
  Widget _topSecton() {
    return SizedBox(
      width: AppSizes.infinity,
      height: AppSizes.s300,
      child: Stack(
        children: [
          // background imaeg
          SizedBox(
            width: double.infinity,
            height: AppSizes.s250,
            child: _getTheImage(),
          ),

          // background imaeg
          Container(
            // width: AppSizes.s300,
            height: AppSizes.s250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    // AppColors.primary,
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
                    Theme.of(context).scaffoldBackgroundColor,
                  ]),
            ),
          ),

          // avatar
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    // select image from gallery
                    final temp = await pickImageFromGallery();

                    // if image is selected update UI
                    if (temp != null) {
                      setState(() {
                        _newImage = temp;
                      });
                    }
                  },
                  child: Container(
                    width: AppSizes.s200,
                    height: AppSizes.s200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.s100),
                      border: Border.all(
                        color: AppColors.primary,
                        width: AppSizes.s4,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizes.s100),
                      child: _getTheImage(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // body section
  Widget _bodySection(isRTL, _textStyle) {
    return Form(
      key: _fromKey,
      child: Column(
        children: [
          _nameControllerSection(_textStyle),
          gap(height: AppSizes.s10),
          _priceControllerSection(_textStyle),
          gap(height: AppSizes.s10),
          _descriptionControllerSection(_textStyle),
          gap(height: AppSizes.s10),
          _categoryControllerSection(_textStyle, isRTL),
          gap(height: AppSizes.s10),
          _quantityControllerSection(isRTL, _textStyle),
          gap(height: AppSizes.s30),

          // save button
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: _saveB_callback,
                  child: Text(context.translate.save),
                ),
              ),
            ],
          ),
          gap(height: AppSizes.s30),
          // delete button
          if(_isUpdating)
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: _deleteB_callback,
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.error)
                  ),
                  child: Text(context.translate.deleted),

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // name controller section
  Widget _nameControllerSection(_textStyle) {
    return // name controller section
        Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.only(top: AppSizes.s14),
            child: Text(
              context.translate.product_name,
              style: _textStyle.bodySmall,
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.translate.enter_name;
              }
              return null;
            },
            style: _textStyle.bodySmall,
            controller: _nameController,
            decoration: InputDecoration(
              hintText: context.translate.enter_product_name,
            ),
          ),
        ),
      ],
    );
  }

  // price controller section
  Widget _priceControllerSection(_textStyle) {
    return // name controller section
        // price section
        Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.only(top: AppSizes.s14),
            child: Text(
              context.translate.price,
              style: _textStyle.bodySmall,
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.translate.enter_price;
              }
              if (int.tryParse(value) == null) {
                return context.translate.enter_valid_price;
              }
              if (int.parse(value) < 0) {
                return context.translate.enter_valid_price;
              }
              return null;
            },
            style: _textStyle.bodySmall,
            controller: _priceController,
            inputFormatters: [
              AppInputFormatter.numbersOnly,
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: context.translate.price,
            ),
          ),
        ),
      ],
    );
  }

  // description controller section
  Widget _descriptionControllerSection(_textStyle) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            context.translate.description,
            style: _textStyle.bodySmall,
          ),
        ),
        Expanded(
          flex: 8,
          child: TextFormField(
            controller: _descController,
            maxLines: 5,
            minLines: 3,
            style: _textStyle.bodySmall,
            decoration: InputDecoration(
              hintText: context.translate.description,
            ),
          ),
        ),
      ],
    );
  }

  // description controller section
  Widget _categoryControllerSection(_textStyle, isRTL) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            context.translate.category,
            style: _textStyle.bodySmall,
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.s4,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.s8),
              border: Border.all(
                color: Theme.of(context)
                    .inputDecorationTheme
                    .enabledBorder!
                    .borderSide
                    .color,
                width: AppSizes.s1,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: _selectedCategory,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
                items: [
                  for (ProductCategoryModel category in widget.categories)
                    DropdownMenuItem(
                      value: category,
                      child: Text(
                        category.name,
                        style: _textStyle.bodySmall,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // quantity controller section
  Widget _quantityControllerSection(isRTL, TextTheme _textStyle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.only(top: AppSizes.s14),
            child: Text(
              context.translate.quantity,
              style: _textStyle.bodySmall,
            ),
          ),
        ),

        // quantity controller
        Expanded(
          flex: 8,
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
                      _quantityController.text = (int.parse(
                                  _quantityController.text.isEmpty
                                      ? "0"
                                      : _quantityController.text) +
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
                          topRight: Radius.circular(isRTL ? 0 : AppSizes.s8),
                          bottomRight: Radius.circular(isRTL ? 0 : AppSizes.s8),
                          bottomLeft: Radius.circular(!isRTL ? 0 : AppSizes.s8),
                          topLeft: Radius.circular(!isRTL ? 0 : AppSizes.s8),
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
                    style: _textStyle.bodySmall,
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
                            color: AppColors.primary.withAlpha(100), width: 2),
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
                            color: AppColors.primary.withAlpha(100), width: 3),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(!isRTL ? 0 : AppSizes.s8),
                          bottomRight:
                              Radius.circular(!isRTL ? 0 : AppSizes.s8),
                          bottomLeft: Radius.circular(isRTL ? 0 : AppSizes.s8),
                          topLeft: Radius.circular(isRTL ? 0 : AppSizes.s8),
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
    );
  }
}
