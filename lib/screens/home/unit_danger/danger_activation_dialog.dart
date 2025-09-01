import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_themes.dart';
import '../../../widgets/buttons/base_text_button.dart';

class DangerActivationDialog extends StatefulWidget {

  const DangerActivationDialog({
    super.key,
  });

  @override
  State<DangerActivationDialog> createState() => _DangerActivationDialogState();
}

class _DangerActivationDialogState extends State<DangerActivationDialog>
    with TickerProviderStateMixin {
  int countdownSeconds = 10;
  late int _currentSeconds;
  Timer? _timer;
  late AnimationController _progressController;
  late AnimationController _pulseController;
  late Animation<double> _progressAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _currentSeconds = countdownSeconds;

    // Slow progress animation controller (matches countdown)
    _progressController = AnimationController(
      duration: Duration(seconds: countdownSeconds),
      vsync: this,
    );

    // Pulse animation controller for the danger icon
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.linear,
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _startCountdown();
    _pulseController.repeat(reverse: true);
  }

  void _startCountdown() {
    // Start slow progress animation
      _progressController.forward();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentSeconds--;
      });

      if (_currentSeconds <= 0) {
        timer.cancel();
        _onComplete();
      }
    });
  }

  void _onUndo() {
    _timer?.cancel();
    _progressController.stop();
    _pulseController.stop();
    Get.back();
  }

  void _onComplete() {
    _timer?.cancel();
    _progressController.stop();
    _pulseController.stop();
    Get.back(result: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        // width: 400.w,
        constraints: BoxConstraints(maxWidth: 448.w),
        padding: EdgeInsets.all(32.w),
        decoration: BoxDecoration(
          color: kPrimary1F,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: kGrey37,width: 2.w),
          boxShadow: [
            BoxShadow(
              color: kBlack.withOpacity(0.3),
              blurRadius: 20.r,
              offset: Offset(0, 10.h),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: _onUndo,
                child: Icon(
                  Icons.close,
                  color: kGrey37,
                  size: 25.r,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Danger icon with pulse animation
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    width: 80.r,
                    height: 80.r,
                    decoration: BoxDecoration(
                      color: kRed.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.warning,
                      color: kRed,
                      size: 40.r,
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 24.h),

            // Title
            Text(
              'active_unit_in_danger'.tr,
              style: Get.textTheme.headlineMedium?.copyWith(
                color: kRed,
                fontSize: 20.sp,
                fontFamily: kBold,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 16.h),

            // Description
            Text(
            'unit_danger_desc'.tr,
              style: Get.textTheme.displayMedium?.copyWith(
                color: kGrey9C,
                fontSize: 14.sp,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 32.h),

            // Countdown number
            Text(
              _currentSeconds.toString(),
              style: Get.textTheme.headlineLarge?.copyWith(
                color: kRed,
                fontSize: 72.sp,
                fontFamily: kBold,
              ),
            ),

            SizedBox(height: 8.h),

            // Countdown text
            Text(
              '${'sending_in'.tr} $_currentSeconds ${'seconds...'.tr}',
              style: Get.textTheme.displayMedium?.copyWith(
                color: kGrey9C,
                fontSize: 14.sp,
              ),
            ),

            SizedBox(height: 24.h),

            // Progress bar with dual animation
            Container(
              height: 6.h,
              decoration: BoxDecoration(
                color: kGrey37,
                borderRadius: BorderRadius.circular(3.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3.r),
                child: Stack(
                  children: [
                    // Background grey bar
                    Container(
                      width: double.infinity,
                      height: 6.h,
                      color: kGrey37,
                    ),

                    // Slow red fill animation (matches countdown - actual progress)
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        return FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: _progressAnimation.value,
                          child: Container(
                            height: 6.h,
                            color:  kRed,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Undo button
            BaseTextButton(
              title: 'undo'.tr,
              onPress: _onUndo,
              primary:  kRed,
              txtColor: kWhite,
              fontSize: 16.sp,
              height: 50.h,
              radius: 8.r,
            ),

            SizedBox(height: 12.h),

            // Extended delay text
            Text(
              'extend_delay_ensure_intentional_activation'.tr,
              style: Get.textTheme.displayMedium?.copyWith(
                color: kGrey9C,
                fontSize: 12.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

