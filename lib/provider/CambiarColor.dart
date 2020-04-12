 

import 'package:flutter/material.dart';

class ThemeState with ChangeNotifier{

  bool _isDarkModeEnable = false;

  ThemeData get 
  currentTheme  => _isDarkModeEnable ? ThemeData.dark().copyWith(
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    
    
    toggleableActiveColor: Colors.redAccent,
    textTheme: TextTheme(
      display1: TextStyle(color: Colors.red)
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.red
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white
    ),
    accentColor: Colors.white
    
  ): ThemeData.light().copyWith(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white
    ),
    accentColor: Colors.green,
    primaryColor: Colors.green,
    backgroundColor: Colors.green,
  );

  bool get isDarkModeEnable => _isDarkModeEnable;

  void setDarkMode(bool b){
    _isDarkModeEnable = b;
    notifyListeners();
  }
}