// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';
import 'package:toastification/toastification.dart';

abstract class AppSnackBarMessages {
  final String title;
  final String message;
  final Icon icon;
  final Color color;
  final ToastificationType type; 
  AppSnackBarMessages(this.title, this.message, this.icon, this.color , this.type);
}

double _iconSize = AppSizes.s50; 

// success snackbar message 
class SuccessSnackBar extends AppSnackBarMessages {
  SuccessSnackBar({required String title, required String message})
      : super(
          title,
          message,
          Icon(Icons.check, size: _iconSize),
          AppColors.success,
          ToastificationType.success,
        );
}

// failed snackbar message 
class FailedSnackBar extends AppSnackBarMessages {
  FailedSnackBar({required String title, required String message})
      : super(
          title,
          message,
          Icon(Icons.close_rounded, size:  _iconSize),
          AppColors.error,
          ToastificationType.error,
        );
}

// warning snackbar message 
class WarningSnackBar extends AppSnackBarMessages {
  WarningSnackBar({required String title, required String message})
      : super(
          title,
          message,
          Icon(Icons.warning_amber_rounded, size:  _iconSize),
          AppColors.warning,
          ToastificationType.warning,
        );
}

// info snackbar message 
class InfoSnackBar extends AppSnackBarMessages {
  InfoSnackBar({required String title, required String message})
      : super(
          title,
          message,
          Icon(Icons.info_outline_rounded, size:  _iconSize),
          AppColors.info,
          ToastificationType.info,
        );
}
