import 'package:flutter/material.dart';
import 'package:ux/Pages/Inicio.dart';
import 'package:ux/Pages/Login.dart';
import 'package:ux/Pages/Perfil.dart';

import 'Pages/HomePage.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diseño',
      home: HomePage(),
      theme: ThemeData(primaryColor: Colors.red),
      routes: {
        // 'home' : (BuildContext context)=> HomePage(),
        'login' : (BuildContext context)=> LoginPage(),
        'perfil' : (BuildContext context)=> Perfil(),
        'inicio' : (BuildContext context)=> InicioPage(),
      },
    );
  }
}