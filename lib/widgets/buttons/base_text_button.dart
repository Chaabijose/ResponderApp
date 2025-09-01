import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_themes.dart';

class BaseTextButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPress;
  final double? height;
  final double? minHeight;
  final double? width;
  final double? minWidth;
  final double? radius;
  final double? elevation;
  final String? fontFamily;
  final Color primary;
  final double fontSize;
  final Color? borderColor;
  final Color? txtColor;
  final Widget? child;

  const BaseTextButton(
      {super.key,
      required this.title,
      this.width,
      this.txtColor,
      this.onPress,
      this.primary = kGrey38,
      this.radius = 12,
      this.height = 50,
      this.elevation,
      this.fontFamily,
      this.minWidth,
      this.minHeight = 50,
      this.child,
      this.borderColor,
      this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(primary),
        shadowColor: WidgetStateProperty.all(primary),
        foregroundColor: WidgetStateProperty.all(txtColor ?? kWhite),
        elevation: WidgetStateProperty.all(elevation ?? 2.0),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular((radius ?? 12).r),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: borderColor == null ? 0 : 1.w
            ),
          ),
        ),
        minimumSize: minWidth == null
            ? WidgetStateProperty.all(Size(0, (minHeight ?? 50)))
            : WidgetStateProperty.all(Size(minWidth!.w, (minHeight ?? 50))),
        fixedSize: minWidth == null
            ? WidgetStateProperty.all(Size(
                width?.w ?? double.infinity,
                (height ?? 50)
              ))
            : null,
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h)
        ),
      ),
      child: child ??
          Text(
            title,
            style: Get.textTheme.displayMedium?.copyWith(
              fontFamily: fontFamily ?? kBold,
              fontSize: fontSize.sp, // ✅ Added .sp here!
              color: txtColor ?? kWhite,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
    );
  }
}
