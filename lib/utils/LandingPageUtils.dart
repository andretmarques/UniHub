import 'package:unihub/constants/Constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPageUtils {

  Align createWelcomeCircle(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Constants.PRIMARY_COLOR
          ),
          width: MediaQuery.of(context).size.width - 80,
        )
    );
  }

  Center createWelcomeString(String username) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text( "Welcome!",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              )

          ),
          const SizedBox(height: 15),
          Text( "User " + username,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 24,
                color: Colors.white
            ),
          ),
        ],
      ),
    );
  }

}