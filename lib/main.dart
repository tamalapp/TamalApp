import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ux/Pages/Inicio.dart';
import 'package:ux/Pages/splash.dart';
import 'package:ux/provider/CambiarColor.dart';
import 'package:ux/provider/DireccionProvider.dart';

import 'Pages/HomePage.dart';
 
void main() {
runApp(MyApp());
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<DireccionProvider>(
          create: (_)=> DireccionProvider(),
        ),
        ChangeNotifierProvider<ThemeState>(
          create: (_)=> ThemeState(),
        )

      ],
      child: Consumer<ThemeState>(
        builder: (context, state, child){
            return MaterialApp(
          
            debugShowCheckedModeBanner: false,
            title: 'TamalApp',
            home: Splash(),
            theme: state.currentTheme,
            
            routes: {
              // 'login' : (BuildContext context)=> LoginPage(),
              'maps'  : (BuildContext context)=> InicioMaps(),
              'home' : (BuildContext context) => HomePage()
            },
          );
        },
      )
    );
  }
}