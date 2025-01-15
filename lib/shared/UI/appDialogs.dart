// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_owner/l10n/l10n.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/bloc/product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productCategoryModel.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/expiredPages/logic/expiredProductsBloc/expired_products_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/ui/pages/expiredPages/logic/models/expiredProductModel.dart';
import 'package:shop_owner/router/navigationService.dart';
import 'package:shop_owner/shared/models/snackBarMessages.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/shared/UI/uiHelper.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/style/languages/logic/bloc/language_bloc_bloc.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/auth/bloc/auth_bloc_bloc.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';

abstract class AppDialogsBase {
  final BuildContext context;

  AppDialogsBase({required this.context});
}

class AppDialogs extends AppDialogsBase {
  AppDialogs({required super.context});

  bool anyDialogVisible = false;

  // ignore: non_constant_identifier_names
  final ButtonStyle _secondary_b_style = const ButtonStyle(
    side: WidgetStatePropertyAll(
      BorderSide(
        color: AppColors.error,
      ),
    ),
    backgroundColor: WidgetStatePropertyAll(
      Colors.transparent,
    ),
    foregroundColor: WidgetStatePropertyAll(AppColors.error),
  );

  AlertDialog _showDialog(Widget child) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: locator<DynamicSizes>().p90,
            maxWidth: locator<DynamicSizes>().p90,
            maxHeight: locator<DynamicSizes>().p50,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10),
            child: child,
          ),
        ),
      ),
    );
  }

  Future<void> showSigningIn({bool isDismissable = false}) async {
    anyDialogVisible = true;

    await showDialog(
      barrierDismissible: isDismissable,
      context: super.context,
      builder: (context) {
        return _showDialog(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const RepaintBoundary(
                child: CircularProgressIndicator(),
              ),
              gap(height: AppSizes.s10),
              Text(
                context.translate.login,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              gap(height: AppSizes.s10),
            ],
          ),
        );
      },
    );

    anyDialogVisible = false;
  }

  Future<void> showCostumTextLoading(
    String text, {
    bool isDismissable = false,
  }) async {
    anyDialogVisible = true;
    await showDialog(
      barrierDismissible: isDismissable,
      context: super.context,
      builder: (context) {
        return _showDialog(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const RepaintBoundary(
                child: CircularProgressIndicator(),
              ),
              gap(height: AppSizes.s10),
              Text(
                text,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),
        );
      },
    );
    anyDialogVisible = false;
  }

  Future<void> showChangeLanguage({
    bool isDismissable = true,
  }) async {
    anyDialogVisible = true;
    await showDialog(
      barrierDismissible: isDismissable,
      context: super.context,
      builder: (context) {
        final _textStyle = Theme.of(context).textTheme;
        return _showDialog(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final local in L10n.all)
                ListTile(
                  onTap: () {
                    context.read<LanguageBloc>().add(
                          ChangeLanguage(local: local),
                        );
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  },
                  trailing: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppSizes.s4,
                      vertical: AppSizes.s2,
                    ),
                    height: AppSizes.s35,
                    width: AppSizes.s45,
                    child: Image.asset(
                      local.flag,
                      fit: BoxFit.cover,
                    ),
                  ),
                  leading: Text(
                    local.languageName,
                    style: _textStyle.displayLarge,
                  ),
                ),
            ],
          ),
        );
      },
    );
    anyDialogVisible = false;
  }

  Future<void> showLogoutConfiramtion({
    bool isDismissable = true,
  }) async {
    anyDialogVisible = true;
    await showDialog(
      barrierDismissible: isDismissable,
      context: super.context,
      builder: (context) {
        final _textStyle = Theme.of(context).textTheme;
        return _showDialog(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.translate.are_you_sure_you_want_to_logout,
                style: _textStyle.displayMedium!
                  ..copyWith(
                    color: AppColors.error,
                  ),
              ),

              gap(height: AppSizes.s20),
              // confirm button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                      context.read<AuthBloc>().add(Logout(context: context));
                    },
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(AppColors.error),
                    ),
                    child: Text(
                      context.translate.yes,
                    ),
                  ),

                  // dispose button
                  TextButton(
                    onPressed: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.success),
                    ),
                    child: Text(
                      context.translate.no,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    anyDialogVisible = false;
  }

  Future<void> showMovingExpiredToDamaged({
    bool isDismissable = true,
    required ExpiredProductModel record,
  }) async {
    anyDialogVisible = true;
    await showDialog(
      barrierDismissible: isDismissable,
      context: super.context,
      builder: (context) {
        final _textStyle = Theme.of(context).textTheme;
        return _showDialog(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "are you sure you want to move this product to the damaged storage",
                textAlign: TextAlign.center,
                style: _textStyle.displayMedium!
                  ..copyWith(
                    color: AppColors.error,
                  ),
              ),

              gap(height: AppSizes.s20),
              // confirm button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      disposeAnyActiveDialogs();
                      super.context.read<ExpiredProductsBloc>().add(
                            GetRidOfExpiredProduct(
                              record: record,
                              context: super.context,
                            ),
                          );

                    },
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(AppColors.error),
                    ),
                    child: Text(
                      context.translate.yes,
                    ),
                  ),

                  // dispose button
                  TextButton(
                    onPressed: () {
                      disposeAnyActiveDialogs();
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.success),
                    ),
                    child: Text(
                      context.translate.no,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    anyDialogVisible = false;
  }

  Future<void> showDeleteProductConfirmation({
    required ProductModel product,
    bool isDismissable = true,
  }) async {
    anyDialogVisible = true;
    await showDialog(
      barrierDismissible: isDismissable,
      context: super.context,
      builder: (context) {
        context = super.context;
        final _textStyle = Theme.of(context).textTheme;
        return _showDialog(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.translate.ru_sure_want_to_delete,
                style: _textStyle.displayMedium,
              ),

              gap(height: AppSizes.s20),
              // confirm button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // accept button
                  TextButton(
                    onPressed: () async {
                      context.read<ProductBloc>().add(
                            DeleteProduct(product: product),
                          );

                      disposeAnyActiveDialogs();
                      anyDialogVisible = true;

                      // send the request to backend
                      // simulating it
                      showLoadingDialog(super.context, 'deleting');
                      await Future.delayed(const Duration(seconds: 2));
                      disposeAnyActiveDialogs();
                      GoRouter.of(context).pop();
                      GoRouter.of(context).pop();

                      // show snackbar
                      showSnackBar(
                        message: SuccessSnackBar(
                          title:
                              "${context.translate.product_deleted_successfully} ${product.name}",
                          message:
                              context.translate.product_deleted_successfully,
                        ),
                      );
                    },
                    style: _secondary_b_style,
                    child: Text(
                      context.translate.yes,
                    ),
                  ),

                  // dispose button
                  TextButton(
                    onPressed: () {
                      disposeAnyActiveDialogs();
                    },
                    style: const ButtonStyle(),
                    child: Text(
                      context.translate.no,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    anyDialogVisible = false;
  }

  Future<void> showDeleteCategoryConfirmation({
    required ProductCategoryModel category,
    bool isDismissable = true,
  }) async {
    anyDialogVisible = true;
    await showDialog(
      barrierDismissible: isDismissable,
      context: super.context,
      builder: (context) {
        final _textStyle = Theme.of(context).textTheme;
        return _showDialog(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.translate.ru_sure_want_to_delete,
                style: _textStyle.displayMedium,
              ),

              gap(height: AppSizes.s20),

              // confirm button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // accept button
                  TextButton(
                    onPressed: () async {
                      disposeAnyActiveDialogs();
                      // send the request to backend
                      // simulating it
                      showLoadingDialog(super.context, 'deleting');
                      await Future.delayed(const Duration(seconds: 2));
                      super.context.read<ProductBloc>().add(
                            DeleteCategory(
                              category: category,
                            ),
                          );
                      // show snackbar

                      GoRouter.of(super.context).pop();
                      GoRouter.of(super.context).pop();
                      // GoRouter.of(super.context).pop();
                      showSnackBar(
                        message: SuccessSnackBar(
                          title:
                              "${super.context.translate.product_deleted_successfully} ${category.name}",
                          message: super
                              .context
                              .translate
                              .product_deleted_successfully,
                        ),
                      );
                    },
                    style: _secondary_b_style,
                    child: Text(
                      context.translate.yes,
                    ),
                  ),

                  // dispose button
                  TextButton(
                    onPressed: () {
                      disposeAnyActiveDialogs();
                    },
                    child: Text(
                      context.translate.no,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    anyDialogVisible = false;
  }

  Future<void> showNotAllowedToDeleteCategory({
    bool isDismissable = true,
  }) async {
    anyDialogVisible = true;
    await showDialog(
      barrierDismissible: isDismissable,
      context: super.context,
      builder: (context) {
        final _textStyle = Theme.of(context).textTheme;
        return _showDialog(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.translate.deleting_category_warning,
                style: _textStyle.displayMedium!.copyWith(
                  color: AppColors.error,
                ),
              ),

              gap(height: AppSizes.s20),

              // confirm button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // dispose button
                  TextButton(
                    onPressed: () {
                      disposeAnyActiveDialogs();
                    },
                    child: Text(
                      context.translate.ok,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    anyDialogVisible = false;
  }

  Future<void> showPlaceOrderConfirmation({
    required ProductCategoryModel category,
    bool isDismissable = true,
  }) async {
    anyDialogVisible = true;
    await showDialog(
      barrierDismissible: isDismissable,
      context: super.context,
      builder: (context) {
        final _textStyle = Theme.of(context).textTheme;
        return _showDialog(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.translate.ru_sure_want_to_delete,
                style: _textStyle.displayMedium,
              ),

              gap(height: AppSizes.s20),

              // confirm button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // accept button
                  TextButton(
                    onPressed: () async {
                      disposeAnyActiveDialogs();
                      // send the request to backend
                      // simulating it
                      showLoadingDialog(super.context, 'deleting');
                      await Future.delayed(const Duration(seconds: 2));
                      super.context.read<ProductBloc>().add(
                            DeleteCategory(
                              category: category,
                            ),
                          );
                      // show snackbar

                      GoRouter.of(super.context).pop();
                      GoRouter.of(super.context).pop();
                      // GoRouter.of(super.context).pop();
                      showSnackBar(
                        message: SuccessSnackBar(
                          title:
                              "${super.context.translate.product_deleted_successfully} ${category.name}",
                          message: super
                              .context
                              .translate
                              .product_deleted_successfully,
                        ),
                      );
                    },
                    style: _secondary_b_style,
                    child: Text(
                      context.translate.yes,
                    ),
                  ),

                  // dispose button
                  TextButton(
                    onPressed: () {
                      disposeAnyActiveDialogs();
                    },
                    child: Text(
                      context.translate.no,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    anyDialogVisible = false;
  }

  void disposeAnyActiveDialogs() {
    if (anyDialogVisible) {
      anyDialogVisible = false;
      locator<NavigationService>().pop();
    }
  }
}
