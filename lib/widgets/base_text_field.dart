import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responder_app/local/localization_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_themes.dart';

class BaseTextField extends StatefulWidget {
  final bool integerVal;
  final bool decimal;
  final String hintTxt;
  final String? labelTxt;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final FormFieldSetter<String>? onSave;
  final FormFieldValidator<String>? validator;
  final bool password;
  final Color filledColor;
  final Color? borderColor;
  final Color? focuseBorderColor;
  final Color? unFocuseBorderColor;
  final Color hintColor;
  final bool readOnly;
  final int? maxLength;
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final String? initialValue;
  final double? radius;
  final bool searchMode;
  final TextInputType? textInputType;
  final int maxLines;
  final int? minLines;
  final bool expands;
  final double fontSize;
  final double contentPaddingLeft;
  final double contentPaddingRight;
  final Color fontColor;
  final double verticalPadding;
  final Widget? suffixIcon;
  final String? suffixText;
  final FocusNode? focusNode;
  final Function? onTap;
  final Widget? prefixIcon;
  final ValueChanged<String>? onSubmit;
  final bool? enabled;
  final AutovalidateMode? validateMode;
  final bool showErrorIcon;
  final IconData? errorIcon;
  final bool useResponsive;

  const BaseTextField(
      {super.key,
      this.integerVal = false,
      this.decimal = false,
      this.useResponsive = false,
      this.onSubmit,
      required this.hintTxt,
      this.labelTxt,
      this.hintStyle,
      this.textStyle,
      this.prefixIcon,
      this.onSave,
      this.suffixIcon,
      this.initialValue,
      this.minLines,
      this.maxLength,
      this.controller,
      this.radius= 8,
      this.filledColor = kGrey37,
      this.borderColor = kGrey9C,
      this.focuseBorderColor = kAccent00,
      this.unFocuseBorderColor = kAccent00,
      this.hintColor = kGreyHint,
      this.password = false,
      this.readOnly = false,
      this.searchMode = false,
      this.maxLines = 1,
      this.expands = false,
      this.onChange,
      this.validator,
      this.fontSize = 16,
      this.labelStyle,
      this.contentPaddingLeft = 16,
      this.contentPaddingRight = 16,
      this.fontColor = kWhite,
      this.verticalPadding = 16,
      this.validateMode,
      this.textInputType,
      this.suffixText,
      this.focusNode,
      this.onTap,
      this.enabled,
      this.showErrorIcon = true,
      this.errorIcon = Icons.error_outline});

  @override
  BaseTextFieldState createState() => BaseTextFieldState();
}

class BaseTextFieldState extends State<BaseTextField> {
  late bool _obscureText;
  var key = GlobalKey();
  String? currentTxt;
  String? currentError;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _obscureText = widget.password;
    super.initState();
  }

  bool get prefixAndLabel =>
      widget.labelTxt != null || widget.prefixIcon != null;

  @override
  Widget build(BuildContext context) {
    if (prefixAndLabel && widget.labelTxt!=null) {
      return Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 11,
            ),
            child: _field(),
          ),
          IntrinsicWidth(
            child: IntrinsicHeight(
              child: Container(
                color: kScaffoldColor,
                margin: EdgeInsetsDirectional.only(start: 18),
                padding: EdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.center,
                child: Text(
                  widget.labelTxt ?? '',
                  style: widget.labelStyle ??
                      Get.textTheme.displayLarge!
                          .copyWith(fontSize: 13,),
                ),
              ),
            ),
          )
        ],
      );
    }
    return _field();
  }

  Widget _field() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          onTap: () => widget.onTap?.call(),
          focusNode: widget.focusNode,
          autovalidateMode: widget.validateMode,
          key: key,
          controller: widget.searchMode ? _searchController : widget.controller,
          autofocus: false,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          textInputAction:widget.textInputType == TextInputType.multiline ? TextInputAction.newline : TextInputAction.done,
          expands: widget.expands,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          initialValue: widget.initialValue,
          maxLength: widget.maxLength,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          onFieldSubmitted: widget.onSubmit,
          onChanged: widget.searchMode
              ? (txt) {
                  widget.onChange?.call(txt);
                  setState(() {
                    currentTxt = txt;
                  });
                }
              : widget.onChange,
          inputFormatters: widget.decimal
              ? [
                  FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)$')),
                ]
              : widget.integerVal
                  ? [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ]
                  : null,
          style: widget.textStyle ??
              Get.textTheme.titleLarge!.copyWith(
                  fontSize: widget.fontSize,
                  color: widget.fontColor,
                  height: 1.6),
          cursorColor: kAccent,
          keyboardType: (widget.textInputType != null)
              ? widget.textInputType
              : widget.decimal
                  ? TextInputType.number
                  : widget.integerVal
                      ? TextInputType.phone
                      : TextInputType.text,
          decoration: InputDecoration(
            suffixText: widget.suffixText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: prefixAndLabel ? null : widget.labelTxt,
            labelStyle: widget.labelStyle ??
                Get.textTheme.displayLarge!.copyWith(
                    fontSize: 13, color: widget.fontColor),
            suffixStyle: TextStyle(color: kPrimary, fontSize: 16),
            filled: true,
            fillColor: widget.filledColor,
            hintText: widget.hintTxt,
            hintStyle: widget.hintStyle ??
                Get.textTheme.titleMedium?.copyWith(
                    color: widget.hintColor, fontSize: 15, fontFamily: kRegular),
            errorStyle: const TextStyle(height: 0, fontSize: 0), // Hide default error
            contentPadding: EdgeInsets.only(
                left: widget.contentPaddingLeft,
                bottom: widget.verticalPadding,
                top: widget.verticalPadding,
                right: widget.contentPaddingRight),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color:widget.focuseBorderColor?? kAccent00, width: 1.6),
              borderRadius: BorderRadius.circular(widget.radius ?? 16),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor ?? kGreyEA,
              ),
              borderRadius: BorderRadius.circular(widget.radius ?? 16),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.unFocuseBorderColor ?? kGreyEA,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(widget.radius ?? 16),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kRed),
              borderRadius: BorderRadius.circular(widget.radius ?? 16),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kRed),
              borderRadius: BorderRadius.circular(widget.radius ?? 16),
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon ?? _suffixIcon(),
          ),
          obscureText: _obscureText,
          onSaved: widget.onSave,
          validator: (value) {
            final error = widget.validator?.call(value);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  currentError = error;
                });
              }
            });
            return error;
          },
        ),
        // Custom error widget with icon
        if (currentError != null && widget.showErrorIcon)
          Padding(
            padding: EdgeInsets.only(top: 8, left: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  widget.errorIcon ?? Icons.error_outline,
                  color: kRed,
                  size: 16,
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    currentError!,
                    style: Get.textTheme.titleMedium!.copyWith(
                      color: kRed,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget? _suffixIcon() {
    if (widget.suffixIcon != null) return widget.suffixIcon;
    return Transform.translate(
      offset: Offset(currentError!=null? 0 :LocalizationService.isRtl()? -10 : 10, 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          if(currentError!=null) Icon(widget.errorIcon??Icons.error_outline,color: kRed, size: 19,),
          widget.password
              ? GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: kGrey9C,
              size: 20,
            ),
          )
              : widget.searchMode
              ? GestureDetector(
            onTap: () {
              if (currentTxt != null && currentTxt!.isNotEmpty) {
                _searchController.text = "";
              }
              setState(() {
                currentTxt = "";
              });
              if (widget.onChange != null) {
                widget.onChange?.call('');
              }
            },
            child: Icon(
              currentTxt == null || currentTxt!.isEmpty
                  ? Icons.search
                  : Icons.close,
              size: 20,
              color: kPrimary,
            ),
          )
              : SizedBox()
        ],
      ),
    );
  }
}
