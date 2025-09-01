import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responder_app/main.dart';

import '../../../theme/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../widgets/avatar/circular_avatar.dart';

class UserWidget extends StatefulWidget {
  final ValueChanged<bool> iconClicked;
  const UserWidget({super.key,required this.iconClicked});

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  var angle = 0.0;
  IconData iconData = Icons.keyboard_arrow_down;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400),animationBehavior: AnimationBehavior.preserve);
    animationController.addListener(() {
      angle = animationController.value * 60 / 360 * pi * 0;
    });
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant UserWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onArrowClick,
      child: Container(
        padding: EdgeInsets.all(customBorderRadius.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(customBorderRadius.r),
          color: kPrimaryLight,
        ),
        child: Row(
          children: [
            CircularAvatar(width: 30.w,height: 30.h,onTap: onArrowClick,),
            SizedBox(width: 6.w,),
            Icon(iconData,color: kWhite,),
          ],
        ),
      ),
    );
  }

  void onArrowClick(){
    setState(() {
      iconEnabled ? animationController.forward() : animationController.reverse();
      iconData = iconEnabled ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up ;
      widget.iconClicked.call(iconEnabled);
    });
  }

  bool get iconEnabled => iconData == Icons.keyboard_arrow_up;


}
