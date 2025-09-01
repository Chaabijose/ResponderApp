import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_images.dart';

class CircularAvatar extends StatelessWidget {
  /// Data *********************************************************************
  final String? avatarUrl;
  final Function? onTap;
  final double? width;
  final double? height;
  final double borderWidth;
  final double borderRadius;
  final String placeHolder;
  final bool fromFile;
  final Color borderColor;
  final bool isElevated;
  final bool showBorder;
  final bool showPercent;
  final double percent;
  final double percentLineWidth;
  final double percentRadius;
  final Color percentProgressColor;
  final BoxShape shape;

  /// Constructors *************************************************************
  const CircularAvatar(
      {super.key,
        this.avatarUrl,
        this.width,
        this.height,
        this.borderWidth = 2,
        this.borderRadius = 12,
        this.onTap,
        this.borderColor = kPrimary,
        this.showBorder = false,
        this.isElevated = false,
        this.placeHolder = AppImages.avatar,
        this.fromFile = false,
        this.showPercent = false,
        this.percent = 1.0,
        this.percentLineWidth = 10.0,
        this.percentRadius = 43.0,
        this.percentProgressColor = kGrey9F,
        this.shape = BoxShape.circle,
      });

  /// Build ********************************************************************
  @override
  Widget build(BuildContext context) {
    return _innerAvatar();
  }

  Widget _innerAvatar() {
    return showPercent ? CircularPercentIndicator(
      percent: percent,
      radius: percentRadius,
      lineWidth: percentLineWidth,
      center: InkWell(
          onTap: () => onTap?.call(),
          child: Container(
            width: width ?? 40.w,
            height: height ?? 40.w,
            decoration: BoxDecoration(
              shape: shape,
              borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(borderRadius.r),
              color: kWhite,
              image: DecorationImage(
                  image: avatarUrl == null || avatarUrl!.isEmpty
                      ? AssetImage(placeHolder)
                      : fromFile
                      ? FileImage(File(avatarUrl!))
                      : CachedNetworkImageProvider(avatarUrl!)
                  as ImageProvider,
                  fit: BoxFit.cover),
              border: Border.all(
                  color: borderColor, width: showBorder ? borderWidth : 0.1),
              boxShadow: !isElevated
                  ? null
                  : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          )),
      progressColor: percentProgressColor,
      backgroundColor: kGreyD0.withOpacity(0.5),
    ) : InkWell(
        onTap: () => onTap?.call(),
        child: Container(
          width: width ?? 40.w,
          height: height ?? 40.w,
          decoration: BoxDecoration(
            shape:shape,
            borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(borderRadius.r),
            color: kWhite,
            image: DecorationImage(
                image: avatarUrl == null || avatarUrl!.isEmpty
                    ? AssetImage(placeHolder)
                    : fromFile
                    ? FileImage(File(avatarUrl!))
                    : CachedNetworkImageProvider(avatarUrl!)
                as ImageProvider,
                fit: BoxFit.cover),
            border: Border.all(
                color: borderColor, width: showBorder ? borderWidth : 0.1),
            boxShadow: !isElevated
                ? null
                : [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
        ));
  }
}
