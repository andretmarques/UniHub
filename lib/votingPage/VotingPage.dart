import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/utils/HalfLogoUtils.dart';
import 'package:unihub/votingPage/SwipeCards.dart';



class VotingPage extends StatefulWidget {
  const VotingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  var halfLogoUtils = HalfLogoUtils();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 150.0)),
            buildTextLabel("Please evaluate 5 tasks"),
                  const SwipeCards()
          ])
    );
  }

  Widget buildTextLabel(String text) {
    return Text(text,
        style: GoogleFonts.roboto(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14)
    );
  }
}