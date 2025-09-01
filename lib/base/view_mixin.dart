import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../models/api/page_properties.dart';
import '../screens/home/widgets/user_widget.dart';
import '../theme/app_colors.dart';
import '../utils/constants.dart';

mixin ViewMixin {
  /// Getters & Setters
  PageProperties get pageProperties;

  Widget buildPage(BuildContext context) {
    return WillPopScope(
      onWillPop: onPopup,
      child: buildScaffold(context),
    );
  }

  /// Build widgets methods
  Widget buildScaffold(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: pageProperties.extendBody,
      drawerDragStartBehavior: DragStartBehavior.start,
      appBar: buildAppBar(),
      backgroundColor: pageProperties.scaffoldColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: buildBody(context),
      ),
      drawer: buildDrawer(),
      bottomNavigationBar: buildBottomBar(context),
      bottomSheet: buildSheet(),
      floatingActionButton: buildFloatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      resizeToAvoidBottomInset: pageProperties.resizeToAvoidBottomInset,
    );
  }

  ///get app-bar ***************************************************************
  AppBar? buildAppBar() {
    if (!pageProperties.showAppBar) return null;

    return AppBar(
      bottom: buildBottomAppBar(),
      backgroundColor: pageProperties.statusBarColor ??
          Get.theme.appBarTheme.backgroundColor,
      centerTitle: pageProperties.centerTitle,
      elevation: pageProperties.appBarElevation,
      actions: buildAppbarActions(),
      titleSpacing: 0,
      leading: buildBackButton(),
      title: buildAppBarTitle(),
    );
  }

  ///Abstract - instance  methods to do extra work after init
  //set tool actions
  List<Widget> buildAppbarActions() {
    return [
      /// Connection state __________________________
      Container(
        padding: EdgeInsets.all(customBorderRadius.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(customBorderRadius.r),
          color: kPrimaryLight,
        ),
        child: Row(
          spacing: 8.w,
          children: [
            Icon(Icons.connect_without_contact, color: kAccent, size: 30.r),
            Icon(Icons.wifi, color: kAccent, size: 30.r),
          ],
        ),
      ),
      SizedBox(
        width: 12.w,
      ),

      /// Notifications __________________________
      GestureDetector(
        // onTap: controller.onShowHideNotification,
        child: Container(
          padding: EdgeInsets.all(customBorderRadius.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(customBorderRadius.r),
            color: kPrimaryLight,
          ),
          child: Icon(
            Icons.notifications_outlined,
            size: 30.r,
            color: kWhite,
          ),
        ),
      ),
      SizedBox(
        width: 12.w,
      ),

      /// User Banner __________________________
      InkWell(
          /*onTap: controller.onlogout,*/ child: UserWidget(
        iconClicked: (bool value) {},
      )),
      SizedBox(
        width: verticalPadding.w,
      ),
    ];
  }

  Widget? buildBackButton() {
    return Get.key.currentState!.canPop()
        ? IconButton(
            icon: Icon(
              pageProperties.closeIcon ? Icons.close : Icons.arrow_back,
              size: 30.w,
            ),
            color: kWhite,
            onPressed: onPopup,
          )
        : null;
  }

  //Build Drawer
  Widget? buildDrawer() {
    return null;
  }

  //Build Your Custom Body
  Widget? buildBody(BuildContext context) {
    return null;
  }

  Widget? buildBottomBar(BuildContext context) {
    return null;
  }

  Widget? buildSheet() {
    return null;
  }

  PreferredSize? buildBottomAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(20.h),
      child: pageProperties.showAppBarLine
          ? Container(
              color: kGrey9C,
              height: 0.2.h,
            )
          : Container(),
    );
  }

  Widget? buildFloatButton() {
    return null;
  }

  Widget buildAppBarTitle() {
    return Text(
      pageProperties.title ?? '',
      style: Get.textTheme.displayLarge?.copyWith(fontSize: 18.sp),
    );
  }

  ///POP ***********************************************************************
  Future<bool> onPopup() {
    Get.back();
    return Future.value(true);
  }
}
