import 'package:flutter/material.dart';
import 'package:unihub/constants/Constants.dart' as Constants;

class HalfLogoUtils {

  Scaffold loadHalfLogo(Enum position) {

    switch (position) {
      case Constants.HALF_LOGO_POSITIONS.CENTER: {
        return Scaffold(
            body: Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top:50),
              child: Image.asset(Constants.HALF_LOGO, scale: 1.5)
            )
        );
      }

      case Constants.HALF_LOGO_POSITIONS.LEFT: {
        return Scaffold(
            body: Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top:50, left: 30),
              child: Image.asset(Constants.HALF_LOGO, scale: 1.5)
            )
        );
      }

      default: {
        return Scaffold(
            body: Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top:50, left: 10),
                child: Image.asset(Constants.HALF_LOGO, scale: 1.5)
            )
        );
      }

    }
  }
}