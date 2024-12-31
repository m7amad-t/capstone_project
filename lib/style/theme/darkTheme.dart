import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_owner/style/appSizes/appPaddings.dart';
import 'package:shop_owner/style/appSizes/appSizes.dart';
import 'package:shop_owner/style/appSizes/fontSizes.dart';
import 'package:shop_owner/style/theme/appColors.dart';

class AppColorsDark {
  static const Color primary = AppColors.primary;
  static const Color textPrimary = Colors.white;
  static Color textSecondary = Colors.grey[400]!;
  static Color textPlaceholder = Colors.grey[500]!;
  static const Color surfacePrimary = Color.fromARGB(255, 22, 0, 35);
  static const Color surfaceSecondary = Color(0xFF2C2C2C);
  static const Color surfaceAccent = Color(0xFF333333);
  static const Color borderPrimary = Color(0xFF444444);
  static const Color borderBrand = AppColors.borderBrand;
  static const Color borderInput = Color(0xFF555555);
  static const Color error = AppColors.error;
  static const Color overPimary = AppColors.onPrimary;
}

ThemeData darkModeThemeData(Locale locale) {
  final bool isEnglish = locale.languageCode == 'en';
  final selectedFont = isEnglish
      ? GoogleFonts.robotoTextTheme()
      : GoogleFonts.ibmPlexSansArabicTextTheme();

  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColorsDark.primary,
    appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
        size: AppSizes.s30, 
        color : AppColorsDark.overPimary, 
      ),
      backgroundColor: AppColorsDark.primary,
      surfaceTintColor:AppColorsDark.primary,
      titleTextStyle: TextStyle(
        fontSize: AppFontSizes.f20,
        fontFamily: isEnglish
            ? GoogleFonts.nunitoSans().fontFamily
            : GoogleFonts.ibmPlexSansArabic().fontFamily,
        color: AppColorsDark.overPimary,
        fontWeight: FontWeight.w600,
        
      ),
    ),
    scaffoldBackgroundColor: AppColorsDark.primary
        .withAlpha(30), // Background color with 30% opacity
    tabBarTheme: TabBarTheme(
      labelColor: AppColorsDark.textPrimary,
      unselectedLabelColor: AppColorsDark.textSecondary,
      dividerColor: AppColorsDark.borderPrimary,
      indicatorColor: AppColorsDark.primary,
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
            color: AppColorsDark.primary,
          ),
        ),
      ),
    ),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppColorsDark.primary),
    inputDecorationTheme: InputDecorationTheme(
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColorsDark.error, width: 1),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColorsDark.error, width: 2),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColorsDark.primary, width: 2),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColorsDark.borderInput, width: 1),
      ),
      hintStyle: TextStyle(
        fontSize: AppFontSizes.f14,
        fontWeight: FontWeight.normal,
        color: AppColorsDark.textPlaceholder,
      ),
      labelStyle: TextStyle(
        fontSize: AppFontSizes.f14,
        fontWeight: FontWeight.normal,
        color: AppColorsDark.textPlaceholder,
      ),
      floatingLabelStyle: TextStyle(
        fontSize: AppFontSizes.f14,
        fontWeight: FontWeight.normal,
        color: AppColorsDark.primary,
      ),
      errorStyle:
          TextStyle(color: AppColorsDark.error, fontSize: AppFontSizes.f10),
      contentPadding: EdgeInsets.symmetric(
          horizontal: AppPaddings.p10, vertical: AppPaddings.p8),
      prefixIconColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.focused)) {
          return AppColorsDark.primary;
        }
        return AppColorsDark.textPlaceholder;
      }),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: AppColorsDark.textSecondary,
      selectedItemColor: AppColorsDark.primary,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle: TextStyle(fontSize: AppFontSizes.f12),
      selectedLabelStyle: TextStyle(fontSize: AppFontSizes.f12),
    ),
    dividerTheme: DividerThemeData(
      space: 0,
      thickness: 1,
      color: AppColorsDark.textPlaceholder,
    ),
    shadowColor: Colors.grey.shade800,
    splashColor: AppColorsDark.primary.withOpacity(0.3),
    canvasColor: AppColorsDark.surfacePrimary,
    cardColor: AppColorsDark.surfacePrimary,
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSizes.s16,
          ),
        ),
      ),
      color: AppColorsDark.surfacePrimary,
      shadowColor: AppColorsDark.primary,
      elevation: AppSizes.s5,
      surfaceTintColor: AppColorsDark.primary,
    ),
    textTheme: selectedFont.copyWith(
      titleLarge: selectedFont.titleLarge?.copyWith(
        fontSize: AppFontSizes.f26,
        color: AppColorsDark.textPrimary,
      ),
      titleMedium: selectedFont.titleMedium?.copyWith(
        fontSize: AppFontSizes.f22,
        color: AppColorsDark.textPrimary,
      ),
      titleSmall: selectedFont.titleSmall?.copyWith(
        fontSize: AppFontSizes.f18,
        color: AppColorsDark.textPrimary,
      ),
      displayLarge: selectedFont.displayLarge?.copyWith(
        fontSize: AppFontSizes.f20,
        color: AppColorsDark.textPrimary.withOpacity(0.7),
      ),
      displayMedium: selectedFont.displayMedium?.copyWith(
        fontSize: AppFontSizes.f18,
        color: AppColorsDark.textPrimary.withOpacity(0.7),
      ),
      displaySmall: selectedFont.displaySmall?.copyWith(
        fontSize: AppFontSizes.f14,
        color: AppColorsDark.textPrimary.withOpacity(0.7),
      ),
      bodyLarge: selectedFont.bodyLarge?.copyWith(
        fontSize: AppFontSizes.f18,
        color: AppColorsDark.textPrimary,
      ),
      bodyMedium: selectedFont.bodyMedium?.copyWith(
        fontSize: AppFontSizes.f16,
        color: AppColorsDark.textPrimary,
      ),
      bodySmall: selectedFont.bodySmall?.copyWith(
        fontSize: AppFontSizes.f12,
        color: AppColorsDark.textPrimary,
      ),
      labelLarge: selectedFont.labelLarge?.copyWith(
        fontSize: AppFontSizes.f14,
        color: AppColorsDark.primary,
      ),
      labelMedium: selectedFont.labelMedium?.copyWith(
        fontSize: AppFontSizes.f10,
        color: AppColorsDark.primary,
      ),
      labelSmall: selectedFont.labelSmall?.copyWith(
        fontSize: AppFontSizes.f6,
        color: AppColorsDark.primary,
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppPaddings.p16))),
      actionsPadding: EdgeInsets.all(AppPaddings.p10),
      backgroundColor: AppColorsDark.surfacePrimary,
      surfaceTintColor: AppColorsDark.surfaceAccent,
      titleTextStyle: TextStyle(
        color: AppColorsDark.textPrimary,
        fontSize: AppFontSizes.f16,
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.black,
      dayStyle: TextStyle(fontSize: AppFontSizes.f14),
      weekdayStyle: TextStyle(fontSize: AppFontSizes.f14),
      yearStyle: TextStyle(fontSize: AppFontSizes.f14),
      headerHeadlineStyle: TextStyle(fontSize: AppFontSizes.f16),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(fontSize: AppFontSizes.f14),
    ),
    listTileTheme: const ListTileThemeData(
        selectedTileColor: AppColorsDark.surfaceSecondary),
    colorScheme: const ColorScheme.dark(
      primary: AppColorsDark.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColorsDark.primary,
      onSecondary: Colors.white,
      error: AppColorsDark.error,
      onError: Colors.white,
      surface: AppColorsDark.surfacePrimary,
      onSurface: AppColorsDark.textPrimary,
      background: AppColorsDark.surfacePrimary,
      onBackground: AppColorsDark.textPrimary,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColorsDark.primary,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppPaddings.p16),
          topRight: Radius.circular(AppPaddings.p16),
        ),
      ),
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: AppColorsDark.surfacePrimary,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: selectedFont.displayLarge?.copyWith(
          fontSize: AppFontSizes.f18,
          color: AppColorsDark.surfacePrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppPaddings.p8,
            ),
          ),
        ),
        backgroundColor: AppColorsDark.primary,
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.p30,
          vertical: AppPaddings.p10,
        ),
        foregroundColor: AppColorsDark.textPrimary,
      ),
    ),
  );
}
