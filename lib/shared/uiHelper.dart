// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_owner/l10n/l10n.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/bloc/product_bloc_bloc.dart';
import 'package:shop_owner/pages/authed/productManagement/logic/models/productModel.dart';
import 'package:shop_owner/shared/models/snackBarMessages.dart';
import 'package:shop_owner/shared/uiComponents.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/style/appSizes/fontSizes.dart';
import 'package:shop_owner/style/languages/logic/bloc/language_bloc_bloc.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:shop_owner/utils/auth/bloc/auth_bloc_bloc.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
import 'package:shop_owner/utils/extensions/l10nHelper.dart';
import 'package:toastification/toastification.dart';

void showLoadingDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Card(
          elevation: 1,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: locator<DynamicSizes>().p50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RepaintBoundary(
                  child: CircularProgressIndicator(),
                ),
                gap(height: 10),
                Text(
                  text,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<void> showChangeLanguage(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      final _textStyle = Theme.of(context).textTheme;
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Card(
          elevation: 1,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: locator<DynamicSizes>().p65,
              maxWidth: locator<DynamicSizes>().p65,
              maxHeight: locator<DynamicSizes>().p50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final local in L10n.all)
                  ListTile(
                    onTap: () {
                      context
                          .read<LanguageBloc>()
                          .add(ChangeLanguage(local: local));
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
          ),
        ),
      );
    },
  );
}

Future<Uint8List?> pickImageFromGallery() async {
  final ImagePicker _picker = ImagePicker();

  // Let the user pick an image
  final XFile? pickedFile =
      await _picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    // Read the image as bytes
    final Uint8List imageBytes = await pickedFile.readAsBytes();
    return imageBytes;
    // Return the image as a MemoryImage
    // return MemoryImage(imageBytes);
  }

  // If no image is selected, return null
  return null;
}

Future<void> showLogoutConfirmation(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      final _textStyle = Theme.of(context).textTheme;
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Card(
          elevation: 1,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: locator<DynamicSizes>().p90,
              maxWidth: locator<DynamicSizes>().p90,
              maxHeight: locator<DynamicSizes>().p50,
            ),
            child: Column(
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
                        context.read<AuthBloc>().add(Logout());
                      },
                      style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(AppColors.error),
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
          ),
        ),
      );
    },
  );
}

Future<void> showDeleteProductConfirmation(
    BuildContext context, ProductModel product) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      final _textStyle = Theme.of(context).textTheme;
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Card(
          elevation: 1,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: locator<DynamicSizes>().p90,
              maxWidth: locator<DynamicSizes>().p90,
              maxHeight: locator<DynamicSizes>().p50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.translate.ru_sure_want_to_delete ,
                  style: _textStyle.displayMedium,
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
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                        // todo : send delete product event to bloc

                        // show snackbar
                        showSnackBar(
                          message: SuccessSnackBar(
                            title:
                                context.translate.product_deleted_successfully,
                            message:
                                context.translate.product_deleted_successfully,
                          ),
                        );

                      },
                      style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(AppColors.error),
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
          ),
        ),
      );
    },
  );
}

void showSnackBar({required AppSnackBarMessages message}) {
  toastification.show(
    dragToClose: true,
    dismissDirection: DismissDirection.down,
    alignment: Alignment.bottomCenter,
    style: ToastificationStyle.flat,
    title: Text(
      message.title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: AppFontSizes.f16,
        color: message.color,
      ),
    ),
    description: Text(message.message),
    type: message.type,
    autoCloseDuration: const Duration(seconds: 5),
    icon: message.icon,
    primaryColor: message.color,
  );
}

void popCurrent(context) {
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }
}
