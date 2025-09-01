import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responder_app/local/localization_service.dart';
import 'package:responder_app/sheets/map_style/map_style_controller.dart';
import 'package:responder_app/theme/app_images.dart';

import '../../theme/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/switch_widget.dart';

class MapStyleSheet extends StatefulWidget {
  const MapStyleSheet({super.key});

  @override
  State<MapStyleSheet> createState() => _MapStyleSheetState();
}

class _MapStyleSheetState extends State<MapStyleSheet> with SingleTickerProviderStateMixin{
  AnimationController? animationController;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: animationController!, curve: Curves.elasticInOut);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!Platform.isIOS) animationController!.forward();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(color: Colors.black.withOpacity(0.1)),
        ),
        Center(
          child: Wrap(
            children: [
              Material(
                color: Colors.transparent,
                child: Platform.isAndroid ? ScaleTransition(scale: scaleAnimation!,child: _body(),) :
                _body(),
              )
              ,
            ],
          ),
        ),
      ],
    );
  }

  Widget _body(){
    return Container(
      width: Get.width,
      height: Get.height,
      decoration:  BoxDecoration(
        color: kPrimary,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r)),
      ),
      child: SafeArea(
        child: GetBuilder(
          init: MapStyleController(),
          builder: (controller)=>Column(
          spacing: 16.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 12.w,
                  children: [
                    Icon(Icons.layers_rounded,color: kBlueSky,size: 30.sp,),
                    Text('map_layers'.tr,style: Get.textTheme.headlineLarge?.copyWith(
                      fontSize: 22.sp,
                    ),),
                  ],
                ),

                GestureDetector(
                  onTap: ()=>Get.back(result: controller.selectedStyle),
                  child: Icon(Icons.clear,color: kGrey9C,),
                )
              ],
            ).paddingSymmetric(horizontal: horizontalPadding.w,),
            Divider(color: kGrey9C,thickness: 0.5.h,),
          SizedBox(
            width: Get.width,
            height: 400.h,
            child: SingleChildScrollView(
              child: Column(
                spacing: 16.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Map styles
                  Text('base_map'.tr,style: Get.textTheme.headlineLarge?.copyWith(
                    fontSize: 20.sp,
                  ),).paddingSymmetric(horizontal: horizontalPadding.w,),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w,),
                    child: Row(
                      spacing: 12.w,
                      children: controller.styles.map((item)=>GestureDetector(
                        onTap: ()=>controller.onChangeStyle(item),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border:  Border.all(color: item == controller.selectedStyle ?kAccent : kGrey9C,width: 2.w) ,
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.asset(item.image?? AppImages.comingSoon,fit: BoxFit.fill,
                                  width: Get.width / 9.3,
                                  height: 100.h,
                                ),
                              ),
                              // Positioned(
                              //     bottom: 12.h,
                              //     child: Text(item.name??'---',style: Get.textTheme.headlineLarge?.copyWith(
                              //   fontSize: 14.sp,
                              // ),)),
                              if(item == controller.selectedStyle) Positioned.directional(
                                top: 8.h,
                                end: 10.w,
                                textDirection: LocalizationService.isRtl() ? TextDirection.rtl : TextDirection.ltr,
                                child: Container(
                                  width: 25.w,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kWhite,
                                      border: Border.all(color: kAccent,width: 6.w)
                                  ),
                                ),),
                            ],
                          ),
                        ),
                      )).toList(),
                    ),
                  ),
                  Divider(color: kGrey9C,thickness: 0.5.h,),

                  /// map layers
                  Text('layers'.tr,style: Get.textTheme.headlineLarge?.copyWith(
                    fontSize: 20.sp,
                  ),).paddingSymmetric(horizontal: horizontalPadding.w,),

                  Column(
                    spacing: 16.h,
                    children: controller.layers.map((item)=>
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(spacing: 8.w,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.r),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: kGrey38,
                                  ),
                                  child: Icon(item.icon!,color: kBlueSky,),
                                ),
                                Text(item.name??'',style: Get.textTheme.headlineLarge?.copyWith(
                                  fontSize: 16.sp,
                                ),),
                              ],
                            ),

                            SwitchWidget(value: item.isEnabled??false, onChanged: (value)=>controller.onChangeLayer(value,item), activeColor: kAccent00)
                          ],
                        )
                    ).toList(),
                  ).paddingSymmetric(horizontal: horizontalPadding.w,),
                ],
              ),
            ),
          )
          ],
                  ),),
      ),
    );
  }

}

