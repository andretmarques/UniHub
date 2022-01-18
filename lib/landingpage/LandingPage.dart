import 'package:flutter/material.dart';
import 'package:unihub/utils/HalfLogoUtils.dart';
import 'package:unihub/utils/LandingPageUtils.dart';

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

  var halfLogoUtils = HalfLogoUtils();
  var landingPageUtils = LandingPageUtils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          halfLogoUtils.loadHalfLogo(),
          Align(
            child: landingPageUtils.createWelcomeCircle(context),
            alignment: Alignment.center,
          ),
          Align(
            child: landingPageUtils.createWelcomeString(username),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}

