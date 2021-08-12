import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider._create({String? themeMode}) {
    if (themeMode == 'light')
      _themeMode = ThemeMode.light;
    else if (themeMode == 'dark')
      _themeMode = ThemeMode.dark;
    else
      _themeMode = ThemeMode.system;

    notifyListeners();
  }

  static Future<ThemeProvider> create() async {
    final box = await Hive.openBox('themeProvider');

    final storedThemeMode = await box.get('themeMode');

    return ThemeProvider._create(themeMode: storedThemeMode);
  }

  void setDarkMode() async {
    _themeMode = ThemeMode.dark;
    notifyListeners();

    final box = await Hive.openBox('themeProvider');
    await box.put('themeMode', 'dark');
  }

  void setLightMode() async {
    _themeMode = ThemeMode.light;
    notifyListeners();
    
    final box = await Hive.openBox('themeProvider');
    await box.put('themeMode', 'light');
  }
}
