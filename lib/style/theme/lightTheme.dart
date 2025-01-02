import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/fontSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';

class AppColorsLight {
  static const Color primary = AppColors.primary;
  static const Color textPrimary = Colors.black;
  static Color textSecondary = Colors.grey[800]!;
  static Color textPlaceholder = Colors.grey[600]!;
  static const Color surfacePrimary = Color(0xFFFFFFFF);
  static const Color surfaceSecondary = Color(0xFFF5F5F5);
  static const Color surfaceAccent = Color(0xFFE0E0E0);
  static const Color borderPrimary = Color(0xFFDDDDDD);
  static const Color borderBrand = AppColors.borderBrand;
  static const Color borderInput = Color(0xFFBBBBBB);
  static const Color error = AppColors.error;
  static const Color overPimary = AppColors.onPrimary;
  static const Color cardColor = Color.fromARGB(255, 183, 223, 255);
}

ThemeData lightModeThemeData(Locale locale) {
  final bool isEnglish = locale.languageCode == 'en';
  final selectedFont = isEnglish
      ? GoogleFonts.robotoTextTheme()
      : GoogleFonts.ibmPlexSansArabicTextTheme();

  return ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColorsLight.primary,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        size: AppSizes.s30,
        color: AppColorsLight.overPimary,
      ),
      backgroundColor: AppColorsLight.primary,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: AppFontSizes.f20,
        fontFamily: isEnglish
            ? GoogleFonts.nunitoSans().fontFamily
            : GoogleFonts.ibmPlexSansArabic().fontFamily,
        color: AppColorsLight.overPimary,
        fontWeight: FontWeight.w600,
      ),
    ),
    scaffoldBackgroundColor: AppColorsLight.surfacePrimary,
    tabBarTheme: TabBarTheme(
      labelColor: AppColorsLight.textPrimary,
      unselectedLabelColor: AppColorsLight.textSecondary,
      dividerColor: AppColorsLight.borderPrimary,
      indicatorColor: AppColorsLight.primary,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: TextStyle(
        fontSize: AppFontSizes.f14,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: AppFontSizes.f14,
        fontWeight: FontWeight.normal,
      ),
      indicator: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColorsLight.primary,
          ),
        ),
      ),
    ),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppColorsLight.primary),
    inputDecorationTheme: InputDecorationTheme(
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColorsLight.error, width: 1),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColorsLight.error, width: 2),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColorsLight.primary, width: 2),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColorsLight.borderInput, width: 1),
      ),
      hintStyle: TextStyle(
        fontSize: AppFontSizes.f14,
        fontWeight: FontWeight.normal,
        color: AppColorsLight.textPlaceholder,
      ),
      labelStyle: TextStyle(
        fontSize: AppFontSizes.f14,
        fontWeight: FontWeight.normal,
        color: AppColorsLight.textPlaceholder,
      ),
      floatingLabelStyle: TextStyle(
        fontSize: AppFontSizes.f14,
        fontWeight: FontWeight.normal,
        color: AppColorsLight.primary,
      ),
      errorStyle:
          TextStyle(color: AppColorsLight.error, fontSize: AppFontSizes.f10),
      contentPadding: EdgeInsets.symmetric(
          horizontal: AppPaddings.p10, vertical: AppPaddings.p8),
      prefixIconColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.focused)) {
          return AppColorsLight.primary;
        }
        return AppColorsLight.textPlaceholder;
      }),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: AppColorsLight.textSecondary,
      selectedItemColor: AppColorsLight.primary,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle: TextStyle(fontSize: AppFontSizes.f12),
      selectedLabelStyle: TextStyle(fontSize: AppFontSizes.f12),
    ),
    dividerTheme: DividerThemeData(
      space: 0,
      thickness: 1,
      color: AppColorsLight.textPlaceholder,
    ),
    shadowColor: Colors.grey.shade400,
    splashColor: AppColorsLight.primary.withOpacity(0.3),
    canvasColor: AppColorsLight.surfacePrimary,
    cardColor: AppColorsLight.cardColor,
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSizes.s16,
          ),
        ),
      ),
      color: const Color.fromARGB(255, 183, 223, 255),
      // shadowColor: AppColorsLight.primary,
      elevation: AppSizes.s5,
      // surfaceTintColor: AppColorsLight.primary,
    ),
    textTheme: selectedFont.copyWith(
      titleLarge: selectedFont.titleLarge?.copyWith(
        fontSize: AppFontSizes.f26,
        color: AppColorsLight.textPrimary,
      ),
      titleMedium: selectedFont.titleMedium?.copyWith(
        fontSize: AppFontSizes.f22,
        color: AppColorsLight.textPrimary,
      ),
      titleSmall: selectedFont.titleSmall?.copyWith(
        fontSize: AppFontSizes.f18,
        color: AppColorsLight.textPrimary,
      ),
      displayLarge: selectedFont.displayLarge?.copyWith(
        fontSize: AppFontSizes.f20,
        color: AppColorsLight.textPrimary.withOpacity(0.7),
      ),
      displayMedium: selectedFont.displayMedium?.copyWith(
        fontSize: AppFontSizes.f18,
        color: AppColorsLight.textPrimary.withOpacity(0.7),
      ),
      displaySmall: selectedFont.displaySmall?.copyWith(
        fontSize: AppFontSizes.f14,
        color: AppColorsLight.textPrimary.withOpacity(0.7),
      ),
      bodyLarge: selectedFont.bodyLarge?.copyWith(
        fontSize: AppFontSizes.f18,
        color: AppColorsLight.textPrimary,
      ),
      bodyMedium: selectedFont.bodyMedium?.copyWith(
        fontSize: AppFontSizes.f16,
        color: AppColorsLight.textPrimary,
      ),
      bodySmall: selectedFont.bodySmall?.copyWith(
        fontSize: AppFontSizes.f14,
        color: AppColorsLight.textPrimary,
      ),
      labelLarge: selectedFont.labelLarge?.copyWith(
        fontSize: AppFontSizes.f14,
        color: AppColorsLight.primary,
      ),
      labelMedium: selectedFont.labelMedium?.copyWith(
        fontSize: AppFontSizes.f10,
        color: AppColorsLight.primary,
      ),
      labelSmall: selectedFont.labelSmall?.copyWith(
        fontSize: AppFontSizes.f6,
        color: AppColorsLight.primary,
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppPaddings.p16))),
      actionsPadding: EdgeInsets.all(AppPaddings.p10),
      backgroundColor: AppColorsLight.surfacePrimary,
      surfaceTintColor: AppColorsLight.surfaceAccent,
      titleTextStyle: TextStyle(
        color: AppColorsLight.textPrimary,
        fontSize: AppFontSizes.f16,
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      dayStyle: TextStyle(fontSize: AppFontSizes.f14),
      weekdayStyle: TextStyle(fontSize: AppFontSizes.f14),
      yearStyle: TextStyle(fontSize: AppFontSizes.f14),
      headerHeadlineStyle: TextStyle(fontSize: AppFontSizes.f16),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(fontSize: AppFontSizes.f14),
    ),
    listTileTheme: const ListTileThemeData(
        selectedTileColor: AppColorsLight.surfaceSecondary),
    colorScheme: const ColorScheme.light(
      primary: AppColorsLight.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColorsLight.primary,
      onSecondary: Colors.white,
      error: AppColorsLight.error,
      onError: Colors.white,
      surface: AppColorsLight.surfacePrimary,
      onSurface: AppColorsLight.textPrimary,
      background: AppColorsLight.surfacePrimary,
      onBackground: AppColorsLight.textPrimary,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColorsLight.primary,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppPaddings.p16),
          topRight: Radius.circular(AppPaddings.p16),
        ),
      ),
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: AppColorsLight.surfacePrimary,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: selectedFont.displayLarge?.copyWith(
          fontSize: AppFontSizes.f18,
          color: AppColorsLight.surfacePrimary,
        ),
        backgroundColor: AppColorsLight.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppSizes.s8),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.p30,
          vertical: AppPaddings.p10,
        ),
        foregroundColor: AppColorsLight.surfacePrimary,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: selectedFont.displayLarge?.copyWith(
          fontSize: AppFontSizes.f18,
          color: AppColorsLight.primary,
        ),
        backgroundColor: AppColorsLight.surfacePrimary,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColorsLight.primary,
            strokeAlign: AppSizes.s1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(AppSizes.s8),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.p30,
          vertical: AppPaddings.p10,
        ),
        foregroundColor: AppColorsLight.primary,
      ),
    ),
  );
}
