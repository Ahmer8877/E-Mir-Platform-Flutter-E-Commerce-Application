import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeMode themeMode = ThemeMode.system;


  void switchTheme(ThemeMode value) {
    themeMode = value;
    notifyListeners();
  }
}
