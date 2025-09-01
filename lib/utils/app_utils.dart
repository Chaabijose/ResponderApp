
import 'package:flutter/material.dart';

class AppUtils {
  static bool isAudio(String url) {
    final audioExtensions = [
      '.mp3',
      '.wav',
      '.ogg',
      '.aac',
    ];

    final lowerCaseUrl = url.toLowerCase();
    for (final audioExtension in audioExtensions) {
      if (lowerCaseUrl.endsWith(audioExtension)) {
        return true; // It's an audio file
      }
    }

    return false; // Not an audio file
  }

  static bool isFile(String url) {
    final audioExtensions = [
      '.mp3',
      '.wav',
      '.ogg',
      '.aac',
    ];

    final lowerCaseUrl = url.toLowerCase();
    for (final audioExtension in audioExtensions) {
      if (lowerCaseUrl.endsWith(audioExtension)) {
        return true; // It's an audio file
      }
    }

    return false; // Not an audio file
  }

  static Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    // if (hexString.length == 7 || hexString.length == 9) {
    buffer.write('ff'); // Default alpha value
    buffer.write(hexString.replaceFirst('#', ''));
    // }
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String colorToHexRGB(Color color, {bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        '${color.red.toRadixString(16).padLeft(2, '0')}'
        '${color.green.toRadixString(16).padLeft(2, '0')}'
        '${color.blue.toRadixString(16).padLeft(2, '0')}';
  }

}
