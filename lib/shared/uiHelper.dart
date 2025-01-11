// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_owner/l10n/l10n.dart';
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

// Future<void> showChangeLanguage(BuildContext context) async {
//   await showDialog(
//     context: context,
//     barrierDismissible: true,
//     builder: (BuildContext context) {
//       final _textStyle = Theme.of(context).textTheme;
//       return AlertDialog(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         content: Card(
//           elevation: 1,
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               minWidth: locator<DynamicSizes>().p65,
//               maxWidth: locator<DynamicSizes>().p65,
//               maxHeight: locator<DynamicSizes>().p50,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 for (final local in L10n.all)
//                   ListTile(
//                     onTap: () {
//                       context
//                           .read<LanguageBloc>()
//                           .add(ChangeLanguage(local: local));
//                       if (Navigator.of(context).canPop()) {
//                         Navigator.of(context).pop();
//                       }
//                     },
//                     trailing: Container(
//                       margin: EdgeInsets.symmetric(
//                         horizontal: AppSizes.s4,
//                         vertical: AppSizes.s2,
//                       ),
//                       height: AppSizes.s35,
//                       width: AppSizes.s45,
//                       child: Image.asset(
//                         local.flag,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     leading: Text(
//                       local.languageName,
//                       style: _textStyle.displayLarge,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

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

