import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key , required this.username}) : super(key: key);
  final String username;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _LandingWelcomePageState(username: username);
}


class _LandingWelcomePageState extends State<LandingPage> {
  _LandingWelcomePageState ({Key? key , required this.username});
  final String username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Scaffold(
              body: Center(
                child: Image.asset('assets/images/half_logo.png', scale: 1.5),
                heightFactor: 1.7,
      )
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(88, 136, 204, 1),
              ),
              width: MediaQuery.of(context).size.width - 50,
            )
          ),
          Center(
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
          ),
        ],
        ),
    );
  }
}

