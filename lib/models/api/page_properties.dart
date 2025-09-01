import 'package:flutter/material.dart';
import 'package:responder_app/theme/app_colors.dart';

class PageProperties {
  //Data
  final String? title;
  final bool showAppBar, resizeToAvoidBottomInset, extendBody;
  final double appBarElevation;
  final bool closeIcon;
  final bool showAppBarLine;
  final bool centerTitle;
  final Color? statusBarColor;
  final Color? scaffoldColor;

  PageProperties(
      {this.showAppBar = true,
      this.appBarElevation = 0,
      this.extendBody = false,
      this.closeIcon = false,
      this.showAppBarLine = true,
      this.title,
      this.statusBarColor = kPrimary,
      this.resizeToAvoidBottomInset = true,
      this.centerTitle = false,
      this.scaffoldColor = kPrimary1F});
}
