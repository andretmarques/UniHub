

import 'package:flutter/cupertino.dart';

class BezierClipper extends CustomClipper<Path>{
  
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height*0.85); //vertical line
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height*0.85); //quadratic curve
    path.lineTo(size.width, 0); //vertical line
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}