 

import 'package:flutter/material.dart';

class ThemeState with ChangeNotifier{

  bool _isDarkModeEnable = false;

  ThemeData get 
  currentTheme  => _isDarkModeEnable ? ThemeData.dark().copyWith(
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    toggleableActiveColor: Colors.redAccent,
    accentColor: Colors.red,
    textTheme: TextTheme(
      display1: TextStyle(color: Colors.red)
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.red
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.red
    )
  ): ThemeData.light().copyWith(
    primaryColor: Colors.white,
    
  );

  bool get isDarkModeEnable => _isDarkModeEnable;

  void setDarkMode(bool b){
    _isDarkModeEnable = b;
    notifyListeners();
  }
}