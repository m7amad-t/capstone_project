// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_owner/shared/models/snackBarMessages.dart';
import 'package:shop_owner/shared/UI/uiComponents.dart';
import 'package:shop_owner/style/appSizes/dynamicSizes.dart';
import 'package:shop_owner/style/appSizes/fontSizes.dart';
import 'package:shop_owner/utils/di/contextDI.dart';
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
    borderSide: const BorderSide(
      color : Colors.transparent , 
    )
  );
}

