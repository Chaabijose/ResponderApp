import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../models/local_enums.dart';
import '../../../models/status.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_images.dart';
import '../../../utils/constants.dart';

class DrawerPanel extends StatefulWidget {
  final Status currentStatus;
  final Function onCloseDrawer;
  final ValueChanged<MapStyleView> onChangeMapView;
  final MapStyleView selectedView;
  final Function onUnitProfile;
  final Function onInquiry;
  final Function onBroadcasts;
  final Function onMessages;
  final Function onSettings;
  final Function onHelp;
  final String version;
  final String buildNumber;
  const DrawerPanel({super.key, required this.currentStatus, required this.onCloseDrawer, required this.onChangeMapView, required this.selectedView, required this.onUnitProfile, required this.onInquiry, required this.onBroadcasts, required this.onMessages, required this.onSettings, required this.onHelp, required this.version, required this.buildNumber});

  @override
  State<DrawerPanel> createState() => _DrawerPanelState();
}

class _DrawerPanelState extends State<DrawerPanel> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetOpenAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _offsetOpenAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0), // Start off-screen to the left
      end: Offset.zero,         // End at the original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _forward();
  }

  Future<void> _forward() async{
    await _controller.forward(from: 0.0);

  }

  Future<void> _back() async{
    await _controller.reverse(from: 1.0);

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _offsetOpenAnimation,
    child: Container(
      color: kPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// unit and close
          Container(
            padding: EdgeInsets.only(
                left: horizontalPadding.w,
                right: horizontalPadding.w,
                bottom: verticalPadding.h,
                top: 40.h),
            color: kGrey18,
            child: Column(
              spacing: 16.h,
              children: [
                /// unit and close
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 16.w,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kGrey17,
                          ),
                          child: Image.asset(
                            AppImages.police1,
                            width: 35.w,
                          ),
                        ),
                        Column(
                          spacing: 6.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Riyadh 1',
                              style: Get.textTheme.headlineLarge?.copyWith(
                                fontSize: 16.sp,
                              ),
                            ),
                            Row(
                              spacing: 8.w,
                              children: [
                                Icon(
                                  widget.currentStatus.icon,
                                  color: widget.currentStatus.color,
                                ),
                                Text(
                                  widget.currentStatus.title ?? '',
                                  style: Get.textTheme.displayLarge?.copyWith(
                                    fontSize: 16.sp,
                                    color: widget.currentStatus.color,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    GestureDetector(
                        onTap: ()async{
                          await _back();
                          widget.onCloseDrawer.call();
                        },
                        child: Icon(Icons.clear, color: kGrey9C)),
                  ],
                ),

                /// change view
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: kGrey38,
                  ),
                  child: Row(
                    children: MapStyleView.values
                        .map((item) => Expanded(
                      child: GestureDetector(
                        onTap: () => widget.onChangeMapView.call(item),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: widget.selectedView == item
                                ? kAccent00
                                : Colors.transparent,
                          ),
                          child: Row(
                            spacing: 8.w,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.police1,
                                width: 40.w,
                              ),
                              if (item == MapStyleView.nearby)
                                Image.asset(
                                  AppImages.fire,
                                  width: 30.w,
                                ),
                              if (widget.selectedView != item)
                                Text(
                                  item.title.tr,
                                  style: Get.textTheme.displayMedium
                                      ?.copyWith(
                                    fontSize: 14.sp,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                )
              ],
            ),
          ),

          SizedBox(
            height: 30.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
              child: Column(
                spacing: 20.h,
                children: [
                  _drawerItem(
                      title: 'my_unit',
                      body: 'my_unit_body',
                      icon: Icons.safety_check,
                      onTab: () => widget.onUnitProfile()),
                  _drawerItem(
                      title: 'inquiry',
                      body: 'inquiry_body',
                      icon: Icons.search,
                      onTab: () => widget.onInquiry()),
                  Divider(
                    color: kGrey9C,
                    thickness: 1.h,
                  ),
                  _drawerItem(
                      title: 'broadcasts',
                      body: 'broadcasts_body',
                      icon: Icons.keyboard_voice_outlined,
                      onTab: () => widget.onBroadcasts()),
                  _drawerItem(
                      title: 'messages',
                      body: 'messages_body',
                      icon: Icons.message,
                      onTab: () => widget.onMessages()),
                  Divider(
                    color: kGrey9C,
                    thickness: 1.h,
                  ),
                  _drawerItem(
                      title: 'settings',
                      body: 'settings_body',
                      icon: Icons.settings,
                      onTab: () => widget.onSettings()),
                  _drawerItem(
                      title: 'help',
                      body: 'help_body',
                      icon: Icons.help,
                      onTab: () => widget.onHelp()),
                ],
              ),
            ),
          ),

          Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: verticalPadding.h),
            color: kGrey18,
            child: Center(
                child: Text(
                  '${'app_version'.tr}: ${widget.version} (${'build'.tr} ${widget.buildNumber})',
                  style: Get.textTheme.displayMedium?.copyWith(fontSize: 16.sp),
                )),
          )
        ],
      ),
    ),);
  }

  InkWell _drawerItem(
      {required String title,
        required String body,
        required IconData icon,
        required Function onTab}) {
    return InkWell(
      onTap: () => onTab.call(),
      child: Row(
        spacing: 8.w,
        children: [
          Icon(Icons.safety_check, color: kBlueSky),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  title.tr,
                  style: Get.textTheme.displayLarge?.copyWith(
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  body.tr,
                  style: Get.textTheme.displayMedium?.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.keyboard_arrow_right, color: kGrey9C),
        ],
      ),
    );
  }
}
