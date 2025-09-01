import 'package:flutter/material.dart';

import 'app_colors.dart';

class GreyColors extends ThemeExtension<GreyColors> {
  final Color background;
  final Color surface;
  final Color divider;
  final Color disabled;
  final Color hint;
  final Color icon;
  final Color text;
  final Color containerBorder;

  const GreyColors({
    required this.background,
    required this.surface,
    required this.divider,
    required this.disabled,
    required this.hint,
    required this.icon,
    required this.text,
    required this.containerBorder,
  });

  @override
  ThemeExtension<GreyColors> copyWith({
    Color? background,
    Color? surface,
    Color? divider,
    Color? disabled,
    Color? hint,
    Color? icon,
    Color? text,
    Color? containerBorder,
  }) {
    return GreyColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      divider: divider ?? this.divider,
      disabled: disabled ?? this.disabled,
      hint: hint ?? this.hint,
      icon: icon ?? this.icon,
      text: text ?? this.text,
      containerBorder: text ?? this.containerBorder,
    );
  }

  @override
  ThemeExtension<GreyColors> lerp(ThemeExtension<GreyColors>? other, double t) {
    if (other is! GreyColors) {
      return this;
    }
    return GreyColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      hint: Color.lerp(hint, other.hint, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      text: Color.lerp(text, other.text, t)!,
      containerBorder: Color.lerp(containerBorder, other.containerBorder, t)!,
    );
  }

  static GreyColors light = const GreyColors(
    background: grey25,
    surface: grey50,
    divider: grey200,
    disabled: grey400,
    hint: kGrey9F,
    icon: kGrey75,
    text: grey900,
    containerBorder: kGreyEE,
  );

  static GreyColors dark = const GreyColors(
    background: grey900,
    surface: grey800,
    divider: grey700,
    disabled: kGrey75,
    hint: kGrey9F,
    icon: grey400,
    text: kGreyEE,
    containerBorder: kGreyEE,
  );
}