
import 'package:flutter/material.dart';

class DrawerItems extends StatelessWidget {
  
  final text;
  final Function onPressed;
  final Widget icono;

  const DrawerItems({ @required this.text, @required this.onPressed, this.icono});

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      padding: EdgeInsets.zero,
      label: Text(text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
      icon: icono,
      onPressed: onPressed,
    );
  }
}