import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../models/helper/title_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_images.dart';
import 'dropdown_controller.dart';

// ignore: must_be_immutable
class DropDown<M extends TitleModel> extends StatelessWidget {
  ///Attributes *******
  final List<M> _list;
  final ValueChanged<M?> onChange;
  final ValueChanged<int>? onIndexChange;
  final Function? onTap;
  final FocusNode? focusNode;
  final M? initialValue;
  final Color? iconColor;
  final double verticalPadding;
  final double horizontalPadding;
  final double elevation;
  final double containerWidth;
  final Color? textColor;
  final TextStyle? labelStyle;
  final double? borderRadius;
  final Color? borderColor;
  final Color? foucseborderColor;
  final String? hint;
  final String? labelTxt;
  final Color backgroundColor;
  final double fontSize;
  final double ?iconArrowSize;
  final bool allowRead;
  final bool showRequired;
  final String? tag;
  bool allowFirst;
  final Color hintColor;
  final bool disableRtl;
  final bool canReset;
  final FormFieldSetter<M>? onSave;
  final FormFieldValidator<M>? validator;
  final TextStyle? hintStyle;
  final GlobalKey<FormFieldState>? formKey;
  final Widget? prefixIcon;
  final bool? isShowIconArrow;

  DropDown(
    this._list, {
    required this.onChange,
    this.initialValue,
    this.containerWidth = double.infinity,
    this.formKey,
    this.onSave,
    this.validator,
    this.verticalPadding = 5,
    this.horizontalPadding = 5,
    this.elevation = 0,
    this.borderRadius = 8,
    this.onIndexChange,
    this.prefixIcon,
    this.hint,
    this.iconArrowSize ,
    this.labelTxt,
    this.tag,
    this.disableRtl = false,
    this.hintColor = kGreyHint,
    this.borderColor = kGrey9C,
    this.foucseborderColor = kAccent00,
    this.labelStyle,
    this.allowRead = true,
    this.fontSize = 16,
    this.canReset = false,
    this.backgroundColor = kGrey38,
    this.textColor = kWhite,
    this.iconColor = kGreyHint,
    this.focusNode,
    this.onTap,
    this.allowFirst = true,
    this.showRequired = false,
    super.key,
    this.hintStyle,
    this.isShowIconArrow = true,
  });

  bool get prefixAndLabel => labelTxt != null && prefixIcon != null;

  @override
  Widget build(BuildContext context) {
    if (prefixAndLabel) {
      return Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 11.h,
            ),
            child: _dropDown(),
          ),
          IntrinsicWidth(
            child: IntrinsicHeight(
              child: Container(
                color: kScaffoldColor,
                margin: EdgeInsetsDirectional.only(start: 12.w, ),
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                alignment: Alignment.center,
                child: Text(
                  labelTxt ?? '',
                  style: Get.textTheme.displayLarge!
                      .copyWith(fontSize: 13.sp, color: textColor),
                ),
              ),
            ),
          )
        ],
      );
    }
    return _dropDown();
  }

  Widget _dropDown() {
    return GetBuilder<DropDownController>(
        init: DropDownController(),
        tag: tag ?? 'dropDown',
        builder: (_) {
          if (initialValue != null && allowFirst) {
            _.setSelectedValue(initialValue!);
            onChange.call(initialValue);
            allowFirst = false;
          } else if (initialValue != null) {
            _.setSelectedValue(initialValue!);
          } else {
            _.selectedValue.value = null;
          }
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius ?? 15),
                color: backgroundColor),
            child: DropdownButtonFormField<M>(
              key: formKey,
              decoration: InputDecoration(
                errorStyle: Get.textTheme.titleMedium!
                    .copyWith(color: kRed, fontSize: 12.sp),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: prefixAndLabel ? null : labelTxt,
                labelStyle:labelStyle?? Get.textTheme.displayLarge!
                    .copyWith(fontSize: 13.sp, color: textColor),
                contentPadding: EdgeInsetsDirectional.only(
                    end: horizontalPadding,
                    bottom: verticalPadding,
                    top: verticalPadding,
                    start: horizontalPadding),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: foucseborderColor ?? kAccent00),
                  borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: borderColor ?? kGreyEA,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: kRed),
                  borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: kRed),
                  borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
                ),
                prefixIcon: prefixIcon,
              ),
              value: _.selectedValue.value as M?,
              onSaved: onSave,
              validator: validator,
              isExpanded: true,
              iconEnabledColor: iconColor,
              iconDisabledColor: kGreyHint,
              hint: Text(
                hint != null
                    ? hint!
                    : _list.isNotEmpty
                        ? _list.first.title
                        : '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: hintStyle ??
                    Get.textTheme.titleMedium
                        ?.copyWith(color: hintColor, fontSize: 13.sp),
              ),
              isDense: true,
              disabledHint: Text(
                hint != null ? hint! : initialValue?.title ?? "",
                style: Get.textTheme.titleLarge!
                    .copyWith(fontSize: fontSize.sp, color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              dropdownColor: backgroundColor,
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isShowIconArrow ?? true)
                    Padding(
                        padding: EdgeInsetsDirectional.only(end: 0.w),
                        child: SvgPicture.asset(
                          AppImages.arrowDown,
                          width:iconArrowSize?? 16.r,
                          colorFilter: ColorFilter.mode(
                              !allowRead ? kGreyHint : iconColor ?? kGreyHint,
                              BlendMode.srcIn),
                        )),
                  if (showRequired)
                    const Icon(
                      Icons.star,
                      size: 10,
                      color: kBlueBlack,
                    ),
                ],
              ),
              iconSize: 25.r,
              menuMaxHeight: 200.h,
              // underline: const SizedBox(),
              items: _list.map((M value) {
                return DropdownMenuItem<M>(
                    value: value,
                    child: disableRtl
                        ? Directionality(
                            textDirection: TextDirection.ltr,
                            child: _menuText(value))
                        : _menuText(value));
              }).toList(),
              onChanged: !allowRead
                  ? null
                  : (value) {
                      onChange(value);
                      if (onIndexChange != null) {
                        onIndexChange!(_list.indexOf(value!));
                      }
                      _.setSelectedValue(canReset ? null : value);
                    },

              focusNode: focusNode,
              onTap: () => onTap,
            ),
          );
        });
  }

  Widget _menuText(
    M value,
  ) {
    return Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (value.icon != null)
              SvgPicture.asset(value.icon!,
                  colorFilter: ColorFilter.mode(
                      value.modelColor ?? kBlack, BlendMode.srcIn)),
            if (value.icon != null) SizedBox(width: 5.w),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  value.title,
                  style: Get.textTheme.titleLarge!.copyWith(
                      fontSize: fontSize.sp,
                      color: value.modelColor ?? textColor),
                  maxLines: 1,
                ),
              ),
            )
          ],
        ));
  }
}
