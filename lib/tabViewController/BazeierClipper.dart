

import 'dart:developer';

import 'package:flutter/cupertino.dart';

class BezierClipper extends CustomClipper<Path>{
  final double progress;
  final double _heightMul;
  BezierClipper(this.progress, this._heightMul);
  
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double artboardW = 414+ (0) * progress;
    final double artboardH = 389+ (688) * progress;
    final double _xScaling = size.width / artboardW;
    final double _yScaling = size.height / artboardH * (progress + _heightMul);
    path.lineTo((0+ (0) * progress) * _xScaling,(324.76199999999994+ (574.3860000000001) * progress) * _yScaling);
    path.cubicTo((0+ (0) * progress) * _xScaling,(324.76199999999994+ (574.3860000000001) * progress) * _yScaling,(0+ (0) * progress) * _xScaling,(0+ (0) * progress) * _yScaling,(0+ (0) * progress) * _xScaling,(0+ (0) * progress) * _yScaling,);
    path.cubicTo((0+ (0) * progress) * _xScaling,(0+ (0) * progress) * _yScaling,(414+ (0) * progress) * _xScaling,(0+ (0) * progress) * _yScaling,(414+ (0) * progress) * _xScaling,(0+ (0) * progress) * _yScaling,);
    path.cubicTo((414+ (0) * progress) * _xScaling,(0+ (0) * progress) * _yScaling,(414+ (0) * progress) * _xScaling,(325.5+ (575.69) * progress) * _yScaling,(414+ (0) * progress) * _xScaling,(325.5+ (575.69) * progress) * _yScaling,);
    path.cubicTo((360.381+ (0) * progress) * _xScaling,(364.82899999999995+ (645.251) * progress) * _yScaling,(287.624+ (0) * progress) * _xScaling,(389+ (688) * progress) * _yScaling,(207.5+ (0) * progress) * _xScaling,(389+ (688) * progress) * _yScaling,);
    path.cubicTo((126.87300000000005+ (0) * progress) * _xScaling,(389+ (688) * progress) * _yScaling,(53.71199999999999+ (0) * progress) * _xScaling,(364.53+ (644.721) * progress) * _yScaling,(0+ (0) * progress) * _xScaling,(324.76199999999994+ (574.3860000000001) * progress) * _yScaling,);
    path.cubicTo((0+ (0) * progress) * _xScaling,(324.76199999999994+ (574.3860000000001) * progress) * _yScaling,(0+ (0) * progress) * _xScaling,(324.76199999999994+ (574.3860000000001) * progress) * _yScaling,(0+ (0) * progress) * _xScaling,(324.76199999999994+ (574.3860000000001) * progress) * _yScaling,);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}