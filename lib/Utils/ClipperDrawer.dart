
import 'package:flutter/material.dart';

class DrawerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(50, 0);
    path.quadraticBezierTo(0, size.height/2, 50, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;


  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

}