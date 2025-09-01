import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/buttons/base_text_button.dart';

class DangerCancellationDialog extends StatefulWidget {
  const DangerCancellationDialog({
    super.key,
  });

  @override
  State<DangerCancellationDialog> createState() => _DangerCancellationDialogState();
}

class _DangerCancellationDialogState extends State<DangerCancellationDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  
  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    // Shake animation for wrong code
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _shakeAnimation = Tween<double>(
      begin: -5.0,
      end: 5.0,
    ).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.elasticIn,
    ));
    

  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _onConfirm() async {

    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    
    // Simulate loading delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    Get.back(result: false);
  }

  void _onCancel() {
    Get.back(result: true);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: AnimatedBuilder(
        animation: _shakeAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_shakeAnimation.value, 0),
            child: Container(
              width: 400.w,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color:  kPrimary1F,
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
                      onTap: _onCancel,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: kGrey37,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.close,
                          color: kGrey9C,
                          size: 20.r,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 16.h),
                  
                  // Security icon
                  Container(
                    width: 80.r,
                    height: 80.r,
                    decoration: BoxDecoration(
                      color: kWarning.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.security,
                      color: kWarning,
                      size: 40.r,
                    ),
                  ),
                  
                  SizedBox(height: 24.h),
                  
                  // Title
                  Text(
                    'confirm_cancellation'.tr,
                    style: Get.textTheme.headlineMedium?.copyWith(
                      color: kWhite,
                      fontSize: 20.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  SizedBox(height: 16.h),
                  
                  // Description
                  Text(
                    'to_cancel_unit_in_danger_state'.tr,
                    style: Get.textTheme.displayMedium?.copyWith(
                      color: kGrey9C,
                      fontSize: 14.sp,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  SizedBox(height: 32.h),

                  
                  // Buttons
                  Row(
                    children: [
                      // Cancel button
                      Expanded(
                        child: BaseTextButton(
                          title: 'cancel'.tr,
                          onPress:  _onCancel,
                          primary: kGrey37,
                          txtColor: kWhite,
                          fontSize: 16.sp,
                          height: 50.h,
                          radius: 8.r,
                        ),
                      ),
                      
                      SizedBox(width: 16.w),
                      
                      // Confirm button
                      Expanded(
                        child: BaseTextButton(
                          title: 'confirm'.tr,
                          onPress: _isLoading ? null : _onConfirm,
                          primary: kGreyD1,
                          txtColor: kWhite,
                          fontSize: 16.sp,
                          height: 50.h,
                          radius: 8.r,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

