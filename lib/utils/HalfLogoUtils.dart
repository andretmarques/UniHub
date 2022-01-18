import 'package:flutter/material.dart';
import 'package:unihub/constants/Constants.dart' as Constants;

class HalfLogoUtils {

  Container loadHalfLogo() {
    return Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(top:50),
        child: Image.asset(Constants.HALF_LOGO, scale: 1.5)
    );
  }
}