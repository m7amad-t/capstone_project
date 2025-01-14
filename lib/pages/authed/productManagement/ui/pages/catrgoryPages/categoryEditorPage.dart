// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/bloc/product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productCategoryModel.dart';
import 'package:shop_owner/shared/UI/appDialogs.dart';
import 'package:shop_owner/shared/models/snackBarMessages.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/shared/UI/uiHelper.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

class CategoryEditorPage extends StatefulWidget {
  final ProductCategoryModel? category;
  final List<ProductCategoryModel> categories;
  const CategoryEditorPage({
    super.key,
    this.category,
    required this.categories,
  });

  @override
  State<CategoryEditorPage> createState() => _CategoryEditorPageState();
}

class _CategoryEditorPageState extends State<CategoryEditorPage> {
  late final GlobalKey<FormState> _fromKey;

  late bool _isUpdating;
  late final TextEditingController _nameController;
  @override
  void initState() {
    super.initState();
    _fromKey = GlobalKey<FormState>();
    _isUpdating = widget.category != null;
    _nameController = TextEditingController(
      text: _isUpdating ? widget.category!.name : "",
    );
  }

  @override
  Widget build(BuildContext context) {
    final _textStyle = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Form(
            key: _fromKey,
            child: Container(
              height: MediaQuery.of(context).size.height - AppSizes.s150,
              padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10),
              child: _body(_textStyle),
            ),
          ),
        ),
      ),
    );
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

    // wait for one second
    await Future.delayed(const Duration(seconds: 2));
    // check if its updating or inserting
    if (_isUpdating) {
      // check if name is udpated
      if (_nameController.text != widget.category!.name) {
        context.read<ProductBloc>().add(
              UpdateCategory(
                category: widget.category!,
                update: {'name': _nameController.text},
              ),
            );
      }
    } else {
      // insert new category
      context.read<ProductBloc>().add(
            InsertCategory(
              category: ProductCategoryModel(
                name: _nameController.text,
                items: const [],
              ),
            ),
          );
    }

    // pop the loading dialog
    locator<AppDialogs>().disposeAnyActiveDialogs();

    // navigate back to product management screen
    if (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }
    // snackbar title
    String title = _isUpdating
        ? context.translate.updated_succesfully
        : context.translate.inserted_successfuly;

    showSnackBar(
      message: SuccessSnackBar(
        title: title,
        message: title,
      ),
    );
  }

  Future<void> _deleteB_callback() async {
    if (widget.category!.items.isEmpty) {
      locator<AppDialogs>()
          .showDeleteCategoryConfirmation(category: widget.category!);
    } else {
      locator<AppDialogs>().showNotAllowedToDeleteCategory();
    }
  } // name controller section

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
              context.translate.category_name,
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
              if (_isUpdating) {
                if (value == widget.category!.name) {
                  return null;
                }
              }
              for (final cat in widget.categories) {
                if (cat.name == value) {
                  return "this name is already in the";
                }
              }
              return null;
            },
            style: _textStyle.bodySmall,
            controller: _nameController,
            decoration: InputDecoration(
              hintText: context.translate.enter_category_name,
            ),
          ),
        ),
      ],
    );
  }

  Widget _body(TextTheme _textStyle) {
    return Column(
      children: [
        gap(height: AppSizes.s20),
        _nameControllerSection(_textStyle),
        gap(height: AppSizes.s20),
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
                    backgroundColor: WidgetStatePropertyAll(AppColors.error),
                  ),
                  child: Text(context.translate.deleted),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
