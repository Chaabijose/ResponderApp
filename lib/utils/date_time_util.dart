// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../local/localization_service.dart';
import '../theme/app_colors.dart';
import '../extensions/string_extension.dart';

class DateTimeUtil {
  static String toddMMYYYYFormat(DateTime dateTime) {
    return DateFormat("yyyy-MM-dd").format(dateTime);
  }

  static String toMMMYYYYFormat(DateTime dateTime) {
    String format =
        DateFormat("EEEE, ", Get.locale!.languageCode).format(dateTime);
    String format2 =
        DateFormat("dd MMMM ", Get.locale!.languageCode).format(dateTime);
    String format3 = DateFormat(
      "yyyy",
    ).format(dateTime);
    return format + format2 + format3;
  }

  static String weekDayName(DateTime dateTime) {
    return DateFormat(LocalizationService.isRtl() ? 'EEEE' : 'EE',
            Get.locale!.languageCode)
        .format(dateTime)
        .toLowerCase();
  }

  static String toDay(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String toDDMM(DateTime date) {
    return DateFormat('EEEE,d MMM yyyy').format(date);
  }

  static String toDayNameDate(DateTime dateTime) {
    return DateFormat("EEEE d MMM yyyy", Get.locale!.languageCode)
        .format(dateTime);
  }

  static String toDateMonthName(DateTime dateTime) {
    return DateFormat("dd MMM yyyy", Get.locale!.languageCode).format(dateTime);
  }

  static String toDateMonthNameRange(
      {required DateTime firstDate, required DateTime lastDate}) {
    return '${DateFormat("dd MMM yyyy", Get.locale!.languageCode).format(firstDate)} - ${DateFormat("dd MMM yyyy", Get.locale!.languageCode).format(lastDate)}';
  }

  static String toDayNameDateAndTime(DateTime dateTime) {
    return '${DateFormat("EEEE d MMM yyyy", Get.locale!.languageCode).format(dateTime)} - ${hhMMAAAFormatArEn(dateTime)}';
  }

  static String toMonthNameDateAndTime(DateTime dateTime) {
    return '${toDateMonthName(dateTime)} - ${hhMMAAAFormatArEn(dateTime)}';
  }

  static String toDateTime24(DateTime dateTime) {
    return DateFormat(
      "yyyy-MM-dd HH:mm",
    ).format(dateTime);
  }

  static String toDayMonth(DateTime dateTime) {
    return DateFormat("d MMM", Get.locale!.languageCode).format(dateTime);
  }

  static String toDateAndTime(DateTime dateTime) {
    return DateFormat("dd-MM-yyyy,  hh:mm aaa", Get.locale!.languageCode)
        .format(dateTime.toLocal());
  }

  static String toDateAndTimeEN(DateTime dateTime) {
    return DateFormat("dd-MM-yyyy,  HH:MM ", "en").format(dateTime.toLocal());
  }

  static DateTime fromDateAndTimeEN(String date) {
    return DateFormat("dd-MM-yyyy,  HH:MM ", "en").parse(date);
  }

  static String hhMMAmPmAr(DateTime dateTime) {
    return DateFormat(
      "hh:mm aaa",
    ).format(dateTime.toLocal());
  }

  static String hhMMAAAFormatArEn(DateTime dateTime) {
    String format = DateFormat("hh:mm aaa", Get.locale!.languageCode)
        .format(dateTime.toLocal());
    if (LocalizationService.isRtl()) {
      String convertArabic = format.contains('ص')
          ? format.replaceAll('ص', 'صباحا')
          : format.contains('م')
              ? format.replaceAll('م', 'مساءً')
              : format;
      return convertArabic.enNumbers;
    } else {
      return format.enNumbers;
    }
  }

  static DateTime toDateTime(TimeOfDay timeOfDay) {
    final now = DateTime.now(); // Use current date
    return DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  }

  static TimeOfDay toTimeOfDay(String timeString) {
    DateTime dateTime = DateFormat.jm().parse(timeString);
    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTime);
    return timeOfDay;
  }

  static TimeOfDay toTimeOfDayServer(String timeString) {
    // Parse the string into a DateTime object
    DateTime parsedDate = DateTime.parse(timeString);

    // Extract the hour and minute
    int hour = parsedDate.hour;
    int minute = parsedDate.minute;

    // Create a TimeOfDay object
    TimeOfDay timeOfDay = TimeOfDay(hour: hour, minute: minute);
    return timeOfDay;
  }

  static String toHoursFromTime(DateTime date, TimeOfDay time) {
    var dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return DateFormat(
      "hh:mm a",
    ).format(dateTime);
  }

  static String toFullTime(DateTime date, TimeOfDay time) {
    var dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return DateFormat(
      "hh:mm:ss",
    ).format(dateTime);
  }

  static DateTime toTimeZone(DateTime date) {
    var timeZoneDateTime = DateTime.utc(
        date.year, date.month, date.day, date.hour, date.minute, date.second);
    return timeZoneDateTime;
  }

  /// Duration *****************************************************************
  static String getTimeDuration(DateTime dateTime) {
    var diff = DateTime.now().difference(dateTime);
    if (diff.inSeconds <= 1) return 'now'.tr;
    if (diff.inSeconds <= 59) return _formatRangeInSeconds(diff);

    if (diff.inMinutes <= 59) return _formatRangeInMinutes(diff);

    if (diff.inHours < 24) return _formatRangeInHours(diff);

    if (diff.inDays < 7) return _formatRangeInDays(diff);

    return toDayNameDateAndTime(dateTime);
  }

  static String getDurationMS(Duration duration) {
    int seconds = duration.inSeconds.remainder(60);
    int minutes = duration.inMinutes.remainder(60);
    return '${seconds < 10 ? seconds.toString().padLeft(2, '0') : seconds} : ${minutes < 10 ? minutes.toString().padLeft(2, '0') : minutes}';
  }

  static String _formatRangeInSeconds(Duration diff) {
    if (!LocalizationService.isRtl()) {
      if (diff.inSeconds == 1) {
        return "1 ${'second'.tr} ${'ago'.tr}";
      } else {
        return "${diff.inSeconds.toString()} ${'seconds'.tr} ${'ago'.tr}";
      }
    } else {
      if (diff.inSeconds == 1) {
        return "${'ago'.tr} ${'second'.tr}";
      } else if (diff.inSeconds == 2) {
        return "${'ago'.tr} ${'two_seconds'.tr}";
      } else if (diff.inSeconds <= 10) {
        return "${'ago'.tr} ${diff.inSeconds.toString()} ${'seconds'.tr}";
      } else {
        return "${'ago'.tr} ${diff.inSeconds.toString()} ${'second'.tr}";
      }
    }
  }

  static String _formatRangeInMinutes(Duration diff) {
    if (!LocalizationService.isRtl()) {
      if (diff.inMinutes == 1) {
        return "1 ${'minute'.tr} ${'ago'.tr}";
      } else {
        return "${diff.inMinutes.toString()} ${'minutes_'.tr} ${'ago'.tr}";
      }
    } else {
      if (diff.inMinutes == 1) {
        return "${'ago'.tr} ${'minute'.tr}";
      } else if (diff.inMinutes == 2) {
        return "${'ago'.tr} ${'two_minutes'.tr}";
      } else if (diff.inMinutes <= 10) {
        return "${'ago'.tr} ${diff.inMinutes.toString()} ${'minutes_'.tr}";
      } else {
        return "${'ago'.tr} ${diff.inMinutes.toString()} ${'minute'.tr}";
      }
    }
  }

  static String _formatRangeInHours(Duration diff) {
    if (!LocalizationService.isRtl()) {
      if (diff.inHours == 1) {
        return "1 ${'hour'.tr} ${'ago'.tr}";
      } else {
        return "${diff.inHours.toString()} ${'hours'.tr} ${'ago'.tr}";
      }
    } else {
      if (diff.inHours == 1) {
        return "${'ago'.tr} ${'hour'.tr}";
      } else if (diff.inHours == 2) {
        return "${'ago'.tr} ${'two_hours'.tr}";
      } else if (diff.inHours <= 10) {
        return "${'ago'.tr} ${diff.inHours.toString()} ${'hours'.tr}";
      } else {
        return "${'ago'.tr} ${diff.inHours.toString()} ${'hour'.tr}";
      }
    }
  }

  static String _formatRangeInDays(Duration diff) {
    if (diff.inDays == 1) return 'yesterday'.tr;
    if (!LocalizationService.isRtl()) {
      return "${diff.inDays.toString()} ${'days'.tr} ${'ago'.tr}";
    } else {
      if (diff.inDays == 2) {
        return "${'ago'.tr} ${'two_days'.tr}";
      } else if (diff.inDays <= 10) {
        return "${'ago'.tr} ${diff.inDays.toString()} ${'days'.tr}";
      } else {
        return "${'ago'.tr} ${diff.inDays.toString()} ${'day_'.tr}";
      }
    }
  }

  static String getDuration(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);
    return '$days ${'days'.tr} : $hours ${'hour'.tr} : $minutes ${'minute'.tr}';
  }

  /// Pickers ******************************************************************
  static Future<DateTime?> selectDate(
      {DateTime? initialValue, DateTime? firstDate, DateTime? lastDate}) async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: initialValue ?? DateTime.now(),
      firstDate: firstDate ?? DateTime.now(),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 120)),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: kPrimary,
            colorScheme: const ColorScheme.light(primary: kPrimary),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    return picked;
  }

  static Future<DateTime?> pickDateTime(
      {DateTime? initialValue, DateTime? firstDate, DateTime? lastDate}) async {
    // Pick Date
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: initialValue ?? DateTime.now(),
      firstDate: firstDate ?? DateTime.now(),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 120)),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: kPrimary,
            colorScheme: const ColorScheme.light(primary: kPrimary),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (pickedDate == null) return null; // User canceled

    // Pick Time
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: initialValue != null
          ? TimeOfDay.fromDateTime(initialValue)
          : TimeOfDay.now(),
      cancelText: 'cancel'.tr,
      confirmText: 'ok'.tr,
      builder: (BuildContext? context, Widget? child) {
        return MediaQuery(
            data: MediaQuery.of(context!)
                .copyWith(alwaysUse24HourFormat: true), // Force 24-hour format
            child: Theme(
              data: ThemeData.light().copyWith(
                primaryColor: kPrimary,
                colorScheme: const ColorScheme.light(primary: kPrimary),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            ));
      },
    );

    if (pickedTime == null) return null; // User canceled

    // Combine Date & Time
    DateTime combinedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    return combinedDateTime;
  }

  static Future<DateTimeRange?> dateRange({
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    var picked = await showDateRangePicker(
        context: Get.context!,
        firstDate: firstDate ?? DateTime.now(),
        lastDate: lastDate ?? DateTime.now().add(const Duration(days: 120)),
        builder: (BuildContext? context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: kPrimary,
              colorScheme: const ColorScheme.light(primary: kPrimary),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        confirmText: 'ok'.tr,
        cancelText: 'cancel'.tr,
        initialDateRange: DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(const Duration(days: 2))));

    return picked;
  }

  static Future<TimeOfDay?> selectTime({DateTime? initialValue}) async {
    initialValue ??= DateTime.now();
    TimeOfDay? picked = await showTimePicker(
        context: Get.context!,
        initialTime:
            TimeOfDay(hour: initialValue.hour, minute: initialValue.minute),
        cancelText: 'cancel'.tr,
        confirmText: 'ok'.tr,
        builder: (BuildContext? context, Widget? child) {
          return MediaQuery(
              data: MediaQuery.of(context!).copyWith(
                  alwaysUse24HourFormat: true), // Force 24-hour format
              child: Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: kPrimary,
                  colorScheme: const ColorScheme.light(primary: kPrimary),
                  buttonTheme:
                      const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              ));
        });
    return picked;
  }

  static DateTime toddMMYYYYFormatDate(String date) {
    return DateFormat("dd MMM yyyy").parse(date);
  }

  static String toddMMYYYYDashFormat(DateTime dateTime) {
    return DateFormat("MM/dd/yyyy").format(dateTime);
  }
}
