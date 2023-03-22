import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:market_place/screens/Auth/storage.dart';
import 'package:market_place/theme/colors.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  getThemeInitial(value) {
    themeMode = value == 'dark'
        ? ThemeMode.dark
        : value == 'light'
            ? ThemeMode.light
            : ThemeMode.system;
    notifyListeners();
  }

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(type) {
    SecureStorage().saveKeyStorage(type, 'theme');
    themeMode = type == 'dark'
        ? ThemeMode.dark
        : type == 'light'
            ? ThemeMode.light
            : ThemeMode.system;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      cardColor: Colors.grey.shade800,
      primaryColor: Colors.grey.withOpacity(0.6),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      textTheme: const TextTheme(displayLarge: TextStyle(color: white)),
      colorScheme:
          const ColorScheme.dark().copyWith(background: Colors.grey.shade900),
      dialogBackgroundColor: Colors.grey.shade900,
      dividerColor: Colors.grey.shade600,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      badgeTheme: BadgeThemeData(backgroundColor: Colors.grey.shade800));

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: white,
      cardColor: white,
      primaryColor: white,
      appBarTheme: const AppBarTheme(backgroundColor: white),
      textTheme: const TextTheme(displayLarge: TextStyle(color: Colors.black)),
      colorScheme: const ColorScheme.light()
          .copyWith(background: const Color(0xfff1f2f5)),
      dialogBackgroundColor: white,
      dividerColor: Colors.grey.shade100,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      badgeTheme: BadgeThemeData(backgroundColor: Colors.grey.shade300));
}
