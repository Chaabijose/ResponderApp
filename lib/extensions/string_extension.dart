import 'package:flutter/material.dart';
import '../environment/flavor_config.dart';
import '../utils/constants.dart';

extension StringExtension on String {
  String get phoneCode => FlavorConfig.isDev() && (this).contains('+')
      ? (this).replaceAll('+', '')
      : FlavorConfig.isDev() && !(this).contains('+')
          ? this
          : (this).contains(kCountryCode)
              ? (this).replaceAll(kCountryCode, '')
              : '$kCountryCode $this'; // production

  String get enNumbers => replaceAllMapped(
        RegExp('[٠-٩]'),
        (match) =>
            String.fromCharCode(match.group(0)!.codeUnitAt(0) - 1632 + 48),
      );

  Color get toColor {
    String hexCode = replaceAll("#", "");
    if (hexCode.length == 6) {
      hexCode = "FF$hexCode"; // Add alpha value if not present
    }
    return Color(int.parse(hexCode, radix: 16));
  }
}
