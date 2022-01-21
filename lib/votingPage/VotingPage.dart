import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/utils/HalfLogoUtils.dart';
import 'package:unihub/constants/Constants.dart' as Constants;
import 'package:unihub/votingPage/SwipeCards.dart';

import 'BazeierClipper.dart';


class VotingPage extends StatefulWidget {
  const VotingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  var halfLogoUtils = HalfLogoUtils();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.52;

    return Scaffold(
        body: Stack(
            children: <Widget>[ClipPath(child:
            Container(color: Constants.PURPLE, height: height),
                clipper: BezierClipper()
            ),
              Column(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Stack(children:
                [Row(children: [const Padding(padding: EdgeInsets.only(right: 20.0)),
                  _buildLogos("HELP"),
                  const Padding(padding: EdgeInsets.only(right: 80.0)),
                  loadHalfLogo(),
                  const Padding(padding: EdgeInsets.only(right: 70.0)),
                  _buildLogos("BELL")],
                )],
                ),
                  buildTextLabel("Please evaluate 5 tasks"),
                  const SwipeCards(),
                ],
              )],
        )
    );
  }

  Container loadHalfLogo() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Image.asset(Constants.HALF_LOGO, scale: 2)
    );
  }

  Widget _buildLogos(String type) {
    var help = const Icon(Icons.help_outline_rounded, size: 40);

    var bell = const Icon(Icons.notifications_none_rounded, size: 40);

    var love = const Icon(Icons.favorite_border_rounded, size: 50, color: Constants.PINK_BUTTON);

    var cross = const Icon(Icons.close, size: 50, color: Constants.PINK_BUTTON);

    var icon;

    switch (type) {
      case "HELP":
        icon = help;
        break;
      case "BELL":
        icon = bell;
        break;
      case "LOVE":
        icon = love;
        break;
      case "CROSS":
        icon = cross;
        break;
    }

    return IconButton(
          icon: icon,
          onPressed: () {}
    );
  }

  Widget buildTextLabel(String text) {
    return Text(text,
        style: GoogleFonts.roboto(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14)
    );
  }
}