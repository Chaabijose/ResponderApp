import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../db/app_pref.dart';
import '../models/local_enums.dart';
import 'app_themes.dart';

class ThemeController extends GetxController {
  static ThemeController get instance => Get.find<ThemeController>();
  
  final AppPreferences _appPreferences = Get.find<AppPreferences>();
  
  // Observable theme mode
  final Rx<ThemeEnum> _currentTheme = ThemeEnum.lite.obs;
  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;
  
  // Getters
  ThemeEnum get currentTheme => _currentTheme.value;
  ThemeMode get themeMode => _themeMode.value;
  bool get isDarkMode => _currentTheme.value == ThemeEnum.dark;
  bool get isLightMode => _currentTheme.value == ThemeEnum.lite;
  
  // Theme data getters
  ThemeData get lightTheme => AppThemes.light;
  ThemeData get darkTheme => AppThemes.dark;
  
  @override
  void onInit() {
    super.onInit();
    _loadThemeFromStorage();
  }
  
  /// Load theme preference from storage
  void _loadThemeFromStorage() {
    try {
      final isDark = _appPreferences.darkTheme;
      final themeEnum = isDark ? ThemeEnum.dark : ThemeEnum.lite;
      _setTheme(themeEnum, saveToStorage: false);
    } catch (e) {
      // Fallback to light theme if there's any error
      _setTheme(ThemeEnum.lite, saveToStorage: true);
    }
  }
  
  /// Change theme
  void changeTheme(ThemeEnum theme) {
    _setTheme(theme, saveToStorage: true);
  }
  
  /// Toggle between light and dark theme
  void toggleTheme() {
    final newTheme = isDarkMode ? ThemeEnum.lite : ThemeEnum.dark;
    changeTheme(newTheme);
  }
  
  /// Set theme internally
  void _setTheme(ThemeEnum theme, {required bool saveToStorage}) {
    _currentTheme.value = theme;
    _themeMode.value = theme == ThemeEnum.dark ? ThemeMode.dark : ThemeMode.light;

    // Update GetX theme
    Get.changeThemeMode(_themeMode.value);

    // Update system UI overlay style
    _updateSystemUIOverlayStyle();

    if (saveToStorage) {
      _saveThemeToStorage(theme);
    }

    update();
  }
  
  /// Save theme preference to storage
  void _saveThemeToStorage(ThemeEnum theme) {
    try {
      _appPreferences.darkTheme = theme == ThemeEnum.dark;
    } catch (e) {
      debugPrint('Error saving theme to storage: $e');
    }
  }
  
  /// Get theme colors based on current theme
  ColorScheme get colorScheme {
    return isDarkMode ? darkTheme.colorScheme : lightTheme.colorScheme;
  }
  
  /// Get text theme based on current theme
  TextTheme get textTheme {
    return isDarkMode ? darkTheme.textTheme : lightTheme.textTheme;
  }
  
  /// Get current theme data
  ThemeData get currentThemeData {
    return isDarkMode ? darkTheme : lightTheme;
  }
  
  /// Convenience methods for common colors
  Color get primaryColor => colorScheme.primary;
  Color get backgroundColor => colorScheme.background;
  Color get surfaceColor => colorScheme.surface;
  Color get onSurfaceColor => colorScheme.onSurface;
  Color get onBackgroundColor => colorScheme.onBackground;
  Color get errorColor => colorScheme.error;
  Color get onPrimaryColor => colorScheme.onPrimary;
  
  /// Check if system is in dark mode
  bool get isSystemDarkMode {
    return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
  }
  
  /// Set theme based on system preference
  void setSystemTheme() {
    final systemTheme = isSystemDarkMode ? ThemeEnum.dark : ThemeEnum.lite;
    changeTheme(systemTheme);
  }
  
  /// Get appropriate text color for current theme
  Color getTextColor({bool isPrimary = true}) {
    if (isDarkMode) {
      return isPrimary ? Colors.white : Colors.white70;
    } else {
      return isPrimary ? Colors.black : Colors.black54;
    }
  }
  
  /// Get appropriate icon color for current theme
  Color getIconColor({bool isPrimary = true}) {
    if (isDarkMode) {
      return isPrimary ? Colors.white : Colors.white70;
    } else {
      return isPrimary ? Colors.black87 : Colors.black54;
    }
  }

  /// Update system UI overlay style based on current theme
  void _updateSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: isDarkMode ? colorScheme.surface : colorScheme.surface,
        systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
  }
}
