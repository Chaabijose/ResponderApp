import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwitchWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color? activeBorderColor;

  const SwitchWidget({super.key, 
    required this.value,
    required this.onChanged,
    required this.activeColor,
     this.activeBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        width: 80.w,
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          color: value ? activeColor : Colors.grey.shade700,
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(
            color: value ? (activeBorderColor ?? Colors.tealAccent.shade100) : Colors.grey.shade600,
            width: 2.w,
          ),
        ),
        child: AnimatedAlign(
          duration: Duration(milliseconds: 100),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
