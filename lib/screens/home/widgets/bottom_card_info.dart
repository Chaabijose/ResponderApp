import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../models/status.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_images.dart';
import '../../../utils/constants.dart';
import '../../../widgets/availablity_status.dart';

class BottomCardInfo extends StatefulWidget {
  final Status currentStatus;
  final Function onUnitInfo;
  final Function onAvailability;
  const BottomCardInfo({super.key, required this.currentStatus, required this.onUnitInfo, required this.onAvailability});

  @override
  State<BottomCardInfo> createState() => _BottomCardInfoState();
}

class _BottomCardInfoState extends State<BottomCardInfo> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
      lowerBound: 0.8,
      upperBound: 1.0,
      animationBehavior: AnimationBehavior.preserve
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine);
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: IntrinsicWidth(
        child: Container(
          padding: EdgeInsets.all(customBorderRadius.r),
          // constraints: BoxConstraints(maxWidth: 300.w,minWidth: 250),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(customBorderRadius.r),
              color: kPrimaryLight,
              border: Border.all(
                  color:
                  widget.currentStatus.color ?? Colors.transparent,
                  width: 3.w)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// unit icon -------------------------
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: kAccent, width: 4.w)),
                child: Image.asset(
                  AppImages.police1,
                  width: 40.w,
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
        
              /// unit name -------------------------
              Text(
                'Riyadh 1',
                style: Get.textTheme.headlineLarge?.copyWith(
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
        
              /// arrow up -------------------------
              Icon(
                Icons.arrow_upward_sharp,
                color: kBlueSky,
                size: 30.r,
              ),
              SizedBox(
                width: 30.w,
              ),
        
              /// Status -----------------------------
              GestureDetector(
                  onTap: () async{
                  await _controller.reverse();
                  await _controller.forward();
                    widget.onAvailability.call();
                    },
                  child: AvailabilityStatus(
                    status: widget.currentStatus,
                  )),
              SizedBox(
                width: 12.w,
              ),
        
              /// unit info -------------------------
              GestureDetector(
                  onTap: ()async{
                    await _controller.reverse();
                    await _controller.forward();
                    widget.onUnitInfo.call();
                  },
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 30.r,
                    color: kGrey9C,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
