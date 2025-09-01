import 'package:flutter/material.dart';

enum MapStyleView {
  myUnit(title: 'my_unit'),
  nearby(title: 'nearby');

  final String title;
  const MapStyleView({required this.title,});
}

enum ThemeEnum {
  dark(title: 'dark'),
  lite(title: 'light');

  final String title;
  const ThemeEnum({required this.title,});
}

enum LanguageEnum {
  arabic(title: 'arabic'),
  english(title: 'english');

  final String title;
  const LanguageEnum({required this.title,});
}

enum MyUnitEnum {
  unitDetails(title: 'unit_details'),
  shiftHistory(title: 'shift_history');

  final String title;
  const MyUnitEnum({required this.title,});
}

enum ShiftHistoryFilter {
  today(title: 'today'),
  last5Events(title: 'last_5_events'),
  thisWeek(title: 'this_week');

  final String title;
  const ShiftHistoryFilter({required this.title,});
}

enum SettingsEnum {
  general(title: 'general',body: 'language_and_preference_settings',icon: Icons.settings_outlined),
  mapNavigation(title: 'map_navigation',body: 'map_preference_layers_and',icon: Icons.map_outlined),
  emergency(title: 'emergency',body: 'critical_safety_and_emergency',icon: Icons.policy_outlined);

  final String title,body;
  final IconData icon;

  const SettingsEnum({required this.title,required this.body,required this.icon,});
}