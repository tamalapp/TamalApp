import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux/Pages/Inicio.dart';
import 'package:ux/Pages/Login.dart';
import 'package:ux/Pages/Perfil.dart';
import 'package:ux/Pages/splash.dart';
import 'package:ux/provider/CambiarColor.dart';

import 'Pages/HomePage.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeState>(
          builder: (_)=> ThemeState(),
        )

      ],
      child: Consumer<ThemeState>(
        builder: (context, state, child){
            return MaterialApp(
          
            debugShowCheckedModeBanner: false,
            title: 'Diseño',
            home: Splash(),
            theme: state.currentTheme,
            
            routes: {
              // 'home' : (BuildContext context)=> HomePage(),
              'login' : (BuildContext context)=> LoginPage(),
              'perfil' : (BuildContext context)=> Perfil(),
              'maps'  : (BuildContext context)=> InicioMaps(),
              'home' : (BuildContext context) => HomePage()
            },
          );
        },
      )
    );
  }
}