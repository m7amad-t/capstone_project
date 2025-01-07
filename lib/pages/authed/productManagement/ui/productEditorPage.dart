// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, use_build_context_synchronously

import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/bloc/product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productCategoryModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/shared/appDialogs.dart';
import 'package:shop_owner/shared/assetPaths.dart';
import 'package:shop_owner/shared/imageDisplayer.dart';
import 'package:shop_owner/shared/models/snackBarMessages.dart';
import 'package:shop_owner/shared/uiComponents.dart';
import 'package:shop_owner/shared/uiHelper.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:shop_owner/utils/inputFormater.dart';

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
          id: -1,
          name: "",
          price: 0,
          imageUrl: '',
          description: '',
          quantity: 0,
        );
    if (widget.categories.isNotEmpty) {
      _selectedCategory = widget.categories.first;
    }
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


  Map<String , dynamic> _getUpdatedFields (){
     // check if its updaiting or inserting..

    Map<String, dynamic> update = {};

    // get name field text
    String currentName = _nameController.text;

    // get quantity field text
    int currentQuantity = int.parse(_quantityController.text);

    // get quantity field text
    double currentPrice = double.parse(_priceController.text);

    // description
    String currentDescription = _descController.text;

    // check with orignal if its changed , add it to the update map
    if (currentName != product.name) {
      update['name'] = currentName;
    }
    if (currentQuantity != product.quantity) {
      update['quantity'] = currentQuantity;
    }
    if (currentPrice != product.price) {
      update['price'] = currentPrice;
    }
    if (currentDescription != product.description) {
      update['description'] = currentDescription;
    }

    return update; 
  }

  Future<void> _saveB_callback() async {
    if (!_fromKey.currentState!.validate()) {
      return;
    }
    // todo : collect values
    // todo : FOR the UI part just relaod products , or update the existing one, one ensert new one

   

    // if product is not provided then create new one , else update the one how provided,

    String loadingDialog =
        _isUpdating ? context.translate.updating : context.translate.uploading;

    // show loading dialog
    locator<AppDialogs>()
        .showCostumTextLoading("$loadingDialog ${context.translate.product}");

    // in here send the request to backend and wait for the ressult..


    // wait for one second : to simulate the reall world example
    await Future.delayed(const Duration(seconds: 1));
    
    if(_isUpdating){
      context.read<ProductBloc>().add(UpdateProduct(
          product: product,
          toUpdate: _getUpdatedFields(),
        ));
    }else {

      // get random values for the id between 100 to 1000
      final random=  Random();
      int newID =100+ random.nextInt(10000);   

      // create a product model with those data 
      product = ProductModel(
        id: newID,  //siging a random ID to not messing with the existing ones 
        name: _nameController.text,
        price: double.parse(_priceController.text),
        imageUrl: 'new url , it come with the response from the backend',
        description: _descController.text,
        quantity: int.parse(_quantityController.text),
      );

      final _category = _selectedCategory ?? widget.categories.first; 
      // send the request to backend and wait for the response..

      // if product is not provided then create new one , else update the one how provided,
      context.read<ProductBloc>().add(InsertProduct(product: product , category: _category));

    }
    
    // update UI based on the response from backend

    

    // pop the loading dialog
    locator<AppDialogs>().disposeAnyActiveDialogs();

    // navigate back to product management screen
    if (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }
    // snackbar title
    String title = _isUpdating
        ? context.translate.product_updated_successfuly
        : context.translate.inserted_succesfully;
    showSnackBar(
      message: SuccessSnackBar(
        title: title,
        message: title,
      ),
    );
  }

  Future<void> _deleteB_callback() async {
    locator<AppDialogs>().showDeleteProductConfirmation(product: product);

    // wait for one second
    // await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final _textStyle = Theme.of(context).textTheme;
    final isRTL = context.fromLTR;

    return Scaffold(
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
          if (_isUpdating)
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _deleteB_callback,
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        AppColors.error,
                      ),
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
              if (double.tryParse(value) == null) {
                return context.translate.enter_valid_price;
              }
              if (double.parse(value) < 0) {
                return context.translate.enter_valid_price;
              }
              return null;
            },
            style: _textStyle.bodySmall,
            controller: _priceController,
            inputFormatters: [
              AppInputFormatter.price,
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
