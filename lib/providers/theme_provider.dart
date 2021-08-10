import 'package:flutter/material.dart';
import 'package:make_me_code/utils/storage_manager.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    StorageManager.readData('themeMode').then((value) {
      final themeMode = value ?? ThemeMode.system;

      if (themeMode == 'light')
        _themeMode = ThemeMode.light;
      else if (themeMode == 'dark')
        _themeMode = ThemeMode.dark;
      else
        _themeMode = themeMode;

      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeMode = ThemeMode.dark;
    await StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeMode = ThemeMode.light;
    await StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
