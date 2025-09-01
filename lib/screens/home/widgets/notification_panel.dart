import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../utils/constants.dart';

class NotificationPanel extends StatefulWidget {
  final Function onCloseNotification;
  const NotificationPanel({super.key, required this.onCloseNotification});

  @override
  State<NotificationPanel> createState() => _NotificationPanelState();
}

class _NotificationPanelState extends State<NotificationPanel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetOpenAnimation;
  late Animation<Offset> _offsetCloseAnimation;
  var isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _offsetOpenAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0), // Start off-screen to the left
      end: Offset.zero, // End at the original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _offsetCloseAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0), // Start off-screen to the left
      end: Offset.zero, // End at the original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _forward();
  }

  Future<void> _forward() async {
    await _controller.forward(from: 0.0);
    setState(() {
      isOpen = true;
    });
  }

  Future<void> _back() async {
    await _controller.reverse(from: 1.0);
    setState(() {
      isOpen = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: isOpen ? _offsetCloseAnimation : _offsetOpenAnimation,
      child: Container(
        color: kPrimary,
        child: Column(
          spacing: 16.h,
          children: [
            SizedBox(
              height: verticalPadding.h,
            ),

            /// title
            Row(
              spacing: 8.w,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    spacing: 16.w,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            await _back();
                            widget.onCloseNotification.call();
                          },
                          child: Icon(
                            Icons.clear,
                            color: kGrey9C,
                          )),
                      Text(
                        'notifications'.tr,
                        style: Get.textTheme.headlineLarge
                            ?.copyWith(fontSize: 20.sp),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    spacing: 8.w,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check,
                        color: kAccent00,
                      ),
                      Expanded(
                        child: Text(
                          'mark_all_read'.tr,
                          style: Get.textTheme.displayMedium
                              ?.copyWith(fontSize: 18.sp),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ).paddingSymmetric(
              horizontal: horizontalPadding.w,
            ),
            Divider(
              color: kGrey9C,
              thickness: 0.5.h,
            ),

            /// list
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (ctx, index) => _notificationItem()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationItem() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.w,
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              color: kAccent00.withAlpha(15),
              child: Icon(
                Icons.mail,
                color: kBlueSky,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6.h,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Central Dispatch',
                        style: Get.textTheme.headlineLarge?.copyWith(
                          fontSize: 18.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Thu',
                        style: Get.textTheme.headlineMedium?.copyWith(
                          fontSize: 16.sp,
                        ),
                      )
                    ],
                  ),
                  Text(
                    'Multiple units needed at King Fahd Road & Olaya intersection. 3-vehicle collision with injuries reported. ETA required immediately.',
                    style: Get.textTheme.displayMedium?.copyWith(
                      fontSize: 16.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Message',
                    style: Get.textTheme.displayMedium?.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            )
          ],
        ).paddingSymmetric(horizontal: horizontalPadding.w),
        SizedBox(
          height: 8.h,
        ),
        Divider(
          color: kGrey9C,
          thickness: 0.5.h,
        ),
        SizedBox(
          height: 16.h,
        ),
      ],
    );
  }
}
