import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// App Spacing Constants
/// Provides consistent spacing, padding, and margin values throughout the app
class AppSpacing {
  // Base spacing units
  static double get xs => 4.w;      // Extra small
  static double get sm => 8.w;      // Small
  static double get md => 16.w;     // Medium
  static double get lg => 24.w;     // Large
  static double get xl => 32.w;     // Extra large
  static double get xxl => 48.w;    // Extra extra large

  // Vertical spacing
  static double get verticalXs => 4.h;
  static double get verticalSm => 8.h;
  static double get verticalMd => 16.h;
  static double get verticalLg => 24.h;
  static double get verticalXl => 32.h;
  static double get verticalXxl => 48.h;

  // Common padding values
  static EdgeInsets get paddingXs => EdgeInsets.all(xs);
  static EdgeInsets get paddingSm => EdgeInsets.all(sm);
  static EdgeInsets get paddingMd => EdgeInsets.all(md);
  static EdgeInsets get paddingLg => EdgeInsets.all(lg);
  static EdgeInsets get paddingXl => EdgeInsets.all(xl);

  // Horizontal padding
  static EdgeInsets get paddingHorizontalXs => EdgeInsets.symmetric(horizontal: xs);
  static EdgeInsets get paddingHorizontalSm => EdgeInsets.symmetric(horizontal: sm);
  static EdgeInsets get paddingHorizontalMd => EdgeInsets.symmetric(horizontal: md);
  static EdgeInsets get paddingHorizontalLg => EdgeInsets.symmetric(horizontal: lg);
  static EdgeInsets get paddingHorizontalXl => EdgeInsets.symmetric(horizontal: xl);

  // Vertical padding
  static EdgeInsets get paddingVerticalXs => EdgeInsets.symmetric(vertical: verticalXs);
  static EdgeInsets get paddingVerticalSm => EdgeInsets.symmetric(vertical: verticalSm);
  static EdgeInsets get paddingVerticalMd => EdgeInsets.symmetric(vertical: verticalMd);
  static EdgeInsets get paddingVerticalLg => EdgeInsets.symmetric(vertical: verticalLg);
  static EdgeInsets get paddingVerticalXl => EdgeInsets.symmetric(vertical: verticalXl);

  // Screen padding (safe area aware)
  static EdgeInsets get screenPadding => EdgeInsets.symmetric(horizontal: md, vertical: verticalMd);
  static EdgeInsets get screenPaddingHorizontal => EdgeInsets.symmetric(horizontal: md);
  static EdgeInsets get screenPaddingVertical => EdgeInsets.symmetric(vertical: verticalMd);

  // Card and container padding
  static EdgeInsets get cardPadding => EdgeInsets.all(md);
  static EdgeInsets get containerPadding => EdgeInsets.all(sm);
  static EdgeInsets get listItemPadding => EdgeInsets.symmetric(horizontal: md, vertical: sm);

  // Button padding
  static EdgeInsets get buttonPadding => EdgeInsets.symmetric(horizontal: lg, vertical: sm);
  static EdgeInsets get buttonPaddingSmall => EdgeInsets.symmetric(horizontal: md, vertical: xs);
  static EdgeInsets get buttonPaddingLarge => EdgeInsets.symmetric(horizontal: xl, vertical: md);

  // Input field padding
  static EdgeInsets get inputPadding => EdgeInsets.symmetric(horizontal: md, vertical: sm);
  static EdgeInsets get inputContentPadding => EdgeInsets.symmetric(horizontal: md, vertical: verticalMd);

  // Dialog and sheet padding
  static EdgeInsets get dialogPadding => EdgeInsets.all(lg);
  static EdgeInsets get sheetPadding => EdgeInsets.all(md);

  // Gap spacing (for Flex widgets)
  static Widget get gapXs => SizedBox(width: xs, height: verticalXs);
  static Widget get gapSm => SizedBox(width: sm, height: verticalSm);
  static Widget get gapMd => SizedBox(width: md, height: verticalMd);
  static Widget get gapLg => SizedBox(width: lg, height: verticalLg);
  static Widget get gapXl => SizedBox(width: xl, height: verticalXl);

  // Horizontal gaps
  static Widget get hGapXs => SizedBox(width: xs);
  static Widget get hGapSm => SizedBox(width: sm);
  static Widget get hGapMd => SizedBox(width: md);
  static Widget get hGapLg => SizedBox(width: lg);
  static Widget get hGapXl => SizedBox(width: xl);

  // Vertical gaps
  static Widget get vGapXs => SizedBox(height: verticalXs);
  static Widget get vGapSm => SizedBox(height: verticalSm);
  static Widget get vGapMd => SizedBox(height: verticalMd);
  static Widget get vGapLg => SizedBox(height: verticalLg);
  static Widget get vGapXl => SizedBox(height: verticalXl);

  // Border radius values
  static double get radiusXs => 4.r;
  static double get radiusSm => 8.r;
  static double get radiusMd => 12.r;
  static double get radiusLg => 16.r;
  static double get radiusXl => 24.r;
  static double get radiusRound => 999.r;

  // Border radius objects
  static BorderRadius get borderRadiusXs => BorderRadius.circular(radiusXs);
  static BorderRadius get borderRadiusSm => BorderRadius.circular(radiusSm);
  static BorderRadius get borderRadiusMd => BorderRadius.circular(radiusMd);
  static BorderRadius get borderRadiusLg => BorderRadius.circular(radiusLg);
  static BorderRadius get borderRadiusXl => BorderRadius.circular(radiusXl);
  static BorderRadius get borderRadiusRound => BorderRadius.circular(radiusRound);

  // Elevation values
  static double get elevationNone => 0;
  static double get elevationXs => 1;
  static double get elevationSm => 2;
  static double get elevationMd => 4;
  static double get elevationLg => 8;
  static double get elevationXl => 16;

  // Icon sizes
  static double get iconXs => 16.w;
  static double get iconSm => 20.w;
  static double get iconMd => 24.w;
  static double get iconLg => 32.w;
  static double get iconXl => 48.w;
}
