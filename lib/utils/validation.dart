import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValidationUtil {
  static String? validateString(input,
      {int maxLength = 1000,
      int minLength = 2,
      FocusNode? node,
      String? errorText}) {
    if (input == null ||
        input.trim().length < minLength ||
        input.isEmpty ||
        input.length > maxLength) {
      if (node != null) {
        node.requestFocus();
      }
      return errorText ?? 'required'.tr;
    }
    return null;
  }

  static String? validateNumber(input,
      {int minLength = 1, String? widgetName}) {
    if (input == null || input.trim().length < minLength || input.isEmpty) {
      return 'required'.tr;
    }
    return null;
  }

  static String? validatePassword(input,
      {int maxLength = 1000, int minLength = 6, FocusNode? node}) {
    if (input == null ||
        input.trim().length < minLength ||
        input.isEmpty ||
        input.length > maxLength) {
      if (node != null) {
        node.requestFocus();
        return 'wrong_password'.tr;
      } else {
        return 'password_required'.tr;
      }
    }

    return null;
  }

  static String? validateEmail(String? input, {FocusNode? node}) {
    if (ValidationUtil.isValidEmail(input)) return null;
    if (input == null || input.isEmpty) return '${'email'.tr} ${"required".tr}';
    if (node != null) {
      node.requestFocus();
      return 'invalid_email_address'.tr;
    } else {
      return 'invalid_email_address'.tr;
    }
  }

  /// ********************************************************************************
  static String? validateWebsite(String? input) {
    if (input == null || input.isEmpty) return 'invalid_entry'.tr;

    // Must contain at least one "."
    if (!input.contains('.')) return 'invalid_entry'.tr;

    // Ensure something exists before and after the first "."
    final parts = input.split('.');
    if (parts.length < 2 || parts[0].isEmpty || parts[1].isEmpty) {
      return 'invalid_entry'.tr;
    }

    return null; // valid
  }

  static String? validateUrl(String? url) {
    if (url == null || url.trim().isEmpty) {
      return 'invalid_link'.tr;
    }

    final uri = Uri.tryParse(url);

    // Allow domain names (example.com) OR IPv4 addresses
    final domainPattern = RegExp(r'^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    final ipPattern = RegExp(r'^(?:\d{1,3}\.){3}\d{1,3}$');

    if (uri != null &&
        uri.hasScheme &&
        uri.hasAuthority &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        (domainPattern.hasMatch(uri.host) || ipPattern.hasMatch(uri.host))) {
      return null; // ✅ valid
    }

    return 'invalid_link'.tr;
  }

  static String? validatePhoneNumber(String? input,
      {int length = 9, int maxLength = 15}) {
    if (input == null || input.isEmpty) {
      return '${'phone_number'.tr} ${'required'.tr}';
    }
    if (input.trim().length < length) {
      return '${'phone_should_be_at_least'.tr} $length ${'numbers'.tr}';
    }
    if (input.trim().length > maxLength) {
      return '${'phone_should_be_at_most'.tr} $length ${'numbers'.tr}';
    }
    // if (input.characters.first != '5') return 'phone_must_start_with5'.tr;
    if (!input.toString().isNumericOnly) return 'wrong_phone_number'.tr;
    if ((double.parse(input)) <= 0) return 'wrong_phone_number'.tr;
    return null;
  }

  static String? validateSuPhoneNumber(input, {int minLength = 9}) {
    if (input == null || input.isEmpty) return 'please_enter_phone'.tr;
    if (input.trim().length < minLength || input.length > 20) {
      return '${'phone_should_be'.tr} $minLength ${'numbers'.tr}';
    }
    if (!input.toString().isNumericOnly) return 'wrong_phone_number'.tr;
    if ((double.parse(input)) <= 0) return 'wrong_phone_number'.tr;
    if (!input.toString().startsWith('5')) return 'phone_should_starts'.tr;
    return null;
  }

  static String arabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    return input;
  }

  static bool isValidEmail(String? email) {
    if (email == null || email.isEmpty) return false;
    return RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
        .hasMatch(email);
  }

  static String? validateRating(int input) {
    if (input == 0) return 'choose_rate'.tr;
    return null;
  }

  static String? isEgyptNumber(String input) {
    if ((input.length == 11 || input.length == 10) && input.startsWith('01') ||
        input.startsWith('1')) {
      return '+20';
    }
    return null;
  }

  static String? validateDate(String? input, {FocusNode? node}) {
    if (input == null || input.isEmpty) return 'date_required'.tr;

    // Here, we'll use a simple format (YYYY-MM-DD) for demonstration purposes.
    final RegExp dateRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');

    if (!dateRegExp.hasMatch(input)) {
      if (node != null) {
        node.requestFocus();
        return 'invalid_date_format'.tr;
      } else {
        return 'invalid_date_format'.tr;
      }
    }
    return null;
  }
}
