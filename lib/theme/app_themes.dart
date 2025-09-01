import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'grey_theme.dart';

class AppThemes {
  /// Rounded shape ************************************************************
  static var shape = RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusLg);
  static var cardShape = RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd);

  /// Light Theme ************************************************************
  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: kScaffoldColor,
    cardColor: kWhite,
    primaryColorDark: kPrimaryDark,
    primaryColor: kPrimary,
    colorScheme: const ColorScheme.light(
      primary: kPrimary,
      secondary: kAccent,
      surface: kWhite,
      surfaceTint: kScaffoldColor,
      error: kRed,
      onPrimary: kWhite,
      onSecondary: kWhite,
      onSurface: kBlack,
      onSurfaceVariant: kBlack,
      onError: kWhite,
    ),
    extensions: [GreyColors.light],
    cardTheme: CardThemeData(
      elevation: AppSpacing.elevationMd,
      color: kWhite,
      shape: cardShape,
      margin: EdgeInsets.zero,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: kScaffoldColor,
      foregroundColor: kBlack,
      iconTheme: const IconThemeData(color: kBlack),
      titleTextStyle: TextStyle(
        color: kBlack,
        fontFamily: kBold,
        fontSize: 18.sp,
      ),
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimary,
        foregroundColor: kWhite,
        padding: AppSpacing.buttonPadding,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
        elevation: AppSpacing.elevationSm,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: kPrimary,
        padding: AppSpacing.buttonPadding,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: kWhite,
      contentPadding: AppSpacing.inputContentPadding,
      border: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        borderSide: const BorderSide(color: kGreyEE),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        borderSide: const BorderSide(color: kGreyEE),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        borderSide: const BorderSide(color: kPrimary, width: 2),
      ),
    ),
    textTheme: _lightTextTheme,
    tabBarTheme: const TabBarThemeData(indicatorColor: kPrimary),
    dividerTheme: const DividerThemeData(color: kGreyEE, thickness: 1),
    iconTheme: const IconThemeData(color: kGrey75),
  );

  /// Dark Theme ************************************************************
  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kDarkScaffold,
    cardColor: kDarkCard,
    primaryColorDark: kDarkPrimaryDark,
    primaryColor: kDarkPrimary,
    colorScheme: const ColorScheme.dark(
      primary: kDarkPrimary,
      secondary: kDarkAccent,
      surface: kDarkSurface,
      background: kDarkBackground,
      error: kDarkError,
      onPrimary: kWhite,
      onSecondary: kWhite,
      onSurface: kDarkTextPrimary,
      onBackground: kDarkTextPrimary,
      onError: kWhite,
    ),
    extensions: [GreyColors.dark],
    cardTheme: CardThemeData(
      elevation: AppSpacing.elevationMd,
      color: kDarkCard,
      shape: cardShape,
      margin: EdgeInsets.zero,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: kDarkAppBar,
      foregroundColor: kDarkTextPrimary,
      iconTheme: const IconThemeData(color: kDarkTextPrimary),
      titleTextStyle: TextStyle(
        color: kDarkTextPrimary,
        fontFamily: kBold,
        fontSize: 18.sp,
      ),
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kDarkPrimary,
        foregroundColor: kWhite,
        padding: AppSpacing.buttonPadding,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
        elevation: AppSpacing.elevationSm,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: kDarkPrimary,
        padding: AppSpacing.buttonPadding,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: kDarkSurface,
      contentPadding: AppSpacing.inputContentPadding,
      border: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        borderSide: const BorderSide(color: kDarkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        borderSide: const BorderSide(color: kDarkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        borderSide: const BorderSide(color: kDarkPrimary, width: 2),
      ),
    ),
    textTheme: _darkTextTheme,
    tabBarTheme: const TabBarThemeData(indicatorColor: kDarkPrimary),
    dividerTheme: const DividerThemeData(color: kDarkDivider, thickness: 1),
    iconTheme: const IconThemeData(color: kDarkTextSecondary),
  );

  /// Light Text Theme ************************************************************
  static TextTheme get _lightTextTheme => TextTheme(
    /// Display - For hero sections and large displays
    displayLarge: TextStyle(
      color: kBlack,
      fontFamily: kBold,
      fontSize: 57.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.25.sp,
      height: 1.12,
    ),
    displayMedium: TextStyle(
      color: kBlack,
      fontFamily: kBold,
      fontSize: 45.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.sp,
      height: 1.16,
    ),
    displaySmall: TextStyle(
      color: kBlack,
      fontFamily: kBold,
      fontSize: 36.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.sp,
      height: 1.22,
    ),

    /// Headline - For page titles and section headers
    headlineLarge: TextStyle(
      color: kBlack,
      fontFamily: kBold,
      fontSize: 32.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.sp,
      height: 1.25,
    ),
    headlineMedium: TextStyle(
      color: kBlack,
      fontFamily: kBold,
      fontSize: 28.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.sp,
      height: 1.29,
    ),
    headlineSmall: TextStyle(
      color: kBlack,
      fontFamily: kBold,
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.sp,
      height: 1.33,
    ),

    /// Title - For card titles and prominent text
    titleLarge: TextStyle(
      color: kBlack,
      fontFamily: kBold,
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.sp,
      height: 1.27,
    ),
    titleMedium: TextStyle(
      color: kBlack,
      fontFamily: kMedium,
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15.sp,
      height: 1.5,
    ),
    titleSmall: TextStyle(
      color: kBlack,
      fontFamily: kMedium,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1.sp,
      height: 1.43,
    ),

    /// Body - For main content and paragraphs
    bodyLarge: TextStyle(
      color: kBlack,
      fontFamily: kRegular,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5.sp,
      height: 1.5,
    ),
    bodyMedium: TextStyle(
      color: kBlack,
      fontFamily: kRegular,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25.sp,
      height: 1.43,
    ),
    bodySmall: TextStyle(
      color: kGrey75,
      fontFamily: kRegular,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4.sp,
      height: 1.33,
    ),

    /// Label - For buttons, tabs, and UI elements
    labelLarge: TextStyle(
      color: kBlack,
      fontFamily: kMedium,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1.sp,
      height: 1.43,
    ),
    labelMedium: TextStyle(
      color: kGrey75,
      fontFamily: kMedium,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5.sp,
      height: 1.33,
    ),
    labelSmall: TextStyle(
      color: kGrey9C,
      fontFamily: kMedium,
      fontSize: 11.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5.sp,
      height: 1.45,
    ),
  );

  /// Dark Text Theme ************************************************************
  static TextTheme get _darkTextTheme => TextTheme(
    /// Display - For hero sections and large displays
    displayLarge: TextStyle(
      color: kDarkTextPrimary,
      fontFamily: kBold,
      fontSize: 57.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.25.sp,
      height: 1.12,
    ),
    displayMedium: TextStyle(
      color: kDarkTextPrimary,
      fontFamily: kBold,
      fontSize: 45.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.sp,
      height: 1.16,
    ),
    displaySmall: TextStyle(
      color: kDarkTextPrimary,
      fontFamily: kBold,
      fontSize: 36.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.sp,
      height: 1.22,
    ),

    /// Headline - For page titles and section headers
    headlineLarge: TextStyle(
      color: kDarkTextPrimary,
      fontFamily: kBold,
      fontSize: 32.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.sp,
      height: 1.25,
    ),
    headlineMedium: TextStyle(
      color: kDarkTextPrimary,
      fontFamily: kBold,
      fontSize: 28.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.sp,
      height: 1.29,
    ),
    headlineSmall: TextStyle(
      color: kDarkTextPrimary,
      fontFamily: kBold,
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.sp,
      height: 1.33,
    ),

    /// Title - For card titles and prominent text
    titleLarge: TextStyle(
      color: kDarkTextPrimary,
      fontFamily: kBold,
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.sp,
      height: 1.27,
    ),
    titleMedium: TextStyle(
      color: kDarkTextPrimary,
      fontFamily: kMedium,
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15.sp,
      height: 1.5,
    ),
    titleSmall: TextStyle(
      color: kDarkTextSecondary,
      fontFamily: kMedium,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1.sp,
      height: 1.43,
    ),

    /// Body - For main content and paragraphs
    bodyLarge: TextStyle(
      color: kDarkTextPrimary,
      fontFamily: kRegular,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5.sp,
      height: 1.5,
    ),
    bodyMedium: TextStyle(
      color: kDarkTextSecondary,
      fontFamily: kRegular,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25.sp,
      height: 1.43,
    ),
    bodySmall: TextStyle(
      color: kDarkTextTertiary,
      fontFamily: kRegular,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4.sp,
      height: 1.33,
    ),

    /// Label - For buttons, tabs, and UI elements
    labelLarge: TextStyle(
      color: kDarkTextPrimary,
      fontFamily: kMedium,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1.sp,
      height: 1.43,
    ),
    labelMedium: TextStyle(
      color: kDarkTextSecondary,
      fontFamily: kMedium,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5.sp,
      height: 1.33,
    ),
    labelSmall: TextStyle(
      color: kDarkTextTertiary,
      fontFamily: kMedium,
      fontSize: 11.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5.sp,
      height: 1.45,
    ),
  );
  /// Custom Text Styles for specific use cases ************************************************************

  /// Button Text Styles
  static TextStyle get buttonTextLarge => TextStyle(
    fontFamily: kMedium,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5.sp,
    height: 1.25,
  );

  static TextStyle get buttonTextMedium => TextStyle(
    fontFamily: kMedium,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25.sp,
    height: 1.43,
  );

  static TextStyle get buttonTextSmall => TextStyle(
    fontFamily: kMedium,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5.sp,
    height: 1.33,
  );

  /// Caption and Helper Text Styles
  static TextStyle get captionText => TextStyle(
    fontFamily: kRegular,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4.sp,
    height: 1.33,
  );

  static TextStyle get helperText => TextStyle(
    fontFamily: kRegular,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4.sp,
    height: 1.33,
  );

  static TextStyle get errorText => TextStyle(
    fontFamily: kRegular,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4.sp,
    height: 1.33,
    color: kRed,
  );

  /// Navigation and Tab Text Styles
  static TextStyle get tabText => TextStyle(
    fontFamily: kMedium,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1.sp,
    height: 1.43,
  );

  static TextStyle get navigationText => TextStyle(
    fontFamily: kMedium,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5.sp,
    height: 1.33,
  );

  /// Input Field Text Styles
  static TextStyle get inputText => TextStyle(
    fontFamily: kRegular,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5.sp,
    height: 1.5,
  );

  static TextStyle get inputLabelText => TextStyle(
    fontFamily: kMedium,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.4.sp,
    height: 1.33,
  );

  static TextStyle get inputHintText => TextStyle(
    fontFamily: kRegular,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5.sp,
    height: 1.5,
  );

  /// Card and List Item Text Styles
  static TextStyle get cardTitle => TextStyle(
    fontFamily: kMedium,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15.sp,
    height: 1.5,
  );

  static TextStyle get cardSubtitle => TextStyle(
    fontFamily: kRegular,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25.sp,
    height: 1.43,
  );

  static TextStyle get listItemTitle => TextStyle(
    fontFamily: kMedium,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15.sp,
    height: 1.5,
  );

  static TextStyle get listItemSubtitle => TextStyle(
    fontFamily: kRegular,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25.sp,
    height: 1.43,
  );

  /// Utility method to get text style with custom color
  static TextStyle getTextStyleWithColor(TextStyle baseStyle, Color color) {
    return baseStyle.copyWith(color: color);
  }

  /// Utility method to get text style with custom size
  static TextStyle getTextStyleWithSize(TextStyle baseStyle, double fontSize) {
    return baseStyle.copyWith(fontSize: fontSize.sp);
  }
}

late String kBold;
late String kMedium;
late String kRegular;

void initFonts({String? lngCode}) {
  kBold = 'Bold';
  kMedium = 'Medium';
  kRegular = 'Regular';
}
