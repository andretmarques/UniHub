import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPageUtils {

  Column createWelcomeString(String username) {
    return Column(
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
        Text( username,
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
              fontSize: 24,
              color: Colors.white
          ),
        ),
      ],
    );
  }
}

