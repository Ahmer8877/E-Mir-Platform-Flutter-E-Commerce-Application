import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeMode themeMode = ThemeMode.light;


  void switchTheme(ThemeMode value) {
    themeMode = value;
    notifyListeners();
  }
}
