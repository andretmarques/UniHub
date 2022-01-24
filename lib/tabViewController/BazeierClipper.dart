

import 'package:flutter/cupertino.dart';

class BezierClipper extends CustomClipper<Path>{
  final double progress;
  BezierClipper(this.progress);
  
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double heightMul = progress + 0.5;
    //
    // final double _xScaling = size.width / 414;
    // final double _yScaling = size.height / 389 * heightMul;
    // path.lineTo(0 * _xScaling,324.76199999999994 * _yScaling);
    // path.cubicTo(0 * _xScaling,324.76199999999994 * _yScaling,0 * _xScaling,0 * _yScaling,0 * _xScaling,0 * _yScaling,);
    // path.cubicTo(0 * _xScaling,0 * _yScaling,414 * _xScaling,0 * _yScaling,414 * _xScaling,0 * _yScaling,);
    // path.cubicTo(414 * _xScaling,0 * _yScaling,414 * _xScaling,325.5 * _yScaling,414 * _xScaling,325.5 * _yScaling,);
    // path.cubicTo(360.381 * _xScaling,364.82899999999995 * _yScaling,287.624 * _xScaling,389 * _yScaling,207.5 * _xScaling,389 * _yScaling,);
    // path.cubicTo(126.87300000000005 * _xScaling,389 * _yScaling,53.71199999999999 * _xScaling,364.53 * _yScaling,0 * _xScaling,324.76199999999994 * _yScaling,);
    // path.cubicTo(0 * _xScaling,324.76199999999994 * _yScaling,0 * _xScaling,324.76199999999994 * _yScaling,0 * _xScaling,324.76199999999994 * _yScaling,);
    final double artboardW = 414+ (0) * progress;
    final double artboardH = 389+ (688) * progress;
    final double _xScaling = size.width / artboardW;
    final double _yScaling = size.height / artboardH * heightMul;
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