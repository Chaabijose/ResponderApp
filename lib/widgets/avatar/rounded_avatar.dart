import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_images.dart';
import '../../utils/image_util.dart';

class RoundedAvatar extends StatelessWidget {
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
  final bool showEdit;

  const RoundedAvatar(
      {super.key,
        this.avatarUrl,
        this.width,
        this.height,
        this.borderWidth = 2,
        this.borderRadius = 10,
        this.onTap,
        this.borderColor = kPrimary,
        this.showBorder = false,
        this.showEdit = false,
        this.isElevated = false,
        this.placeHolder = AppImages.comingSoon,
        this.fromFile = false});

  /// Build ********************************************************************
  @override
  Widget build(BuildContext context) {
    return _innerAvatar();
  }

  Widget _innerAvatar() {
    return SizedBox(
      width: width!=null ? width!  +18: 50.w ,
      height: height!=null ? height!  +18: 50.w,
      child: Stack(
        children: [
          InkWell(
              onTap: () => showEdit  || onTap == null   ? ImageUtil.viewImage(avatarUrl) : onTap!.call(),
              child: Container(
                width: width ?? 50.w,
                height: height ?? 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius.r),
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
              ),),
         if(showEdit) Container(
           margin: EdgeInsetsDirectional.only(bottom: 10.h,end: 24.w),
              alignment: AlignmentDirectional.bottomEnd,
              child: InkWell(
                  onTap: ()=>onTap == null ? ImageUtil.viewImage(avatarUrl) : onTap!.call(),
                  child: SvgPicture.asset(AppImages.editPic,width: 40.w,height: 40.w,))),
        ],
      ),
    );
  }
}
