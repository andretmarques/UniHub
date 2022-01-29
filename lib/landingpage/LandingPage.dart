import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/tabViewController/TabViewController.dart';
import 'package:unihub/utils/HalfLogoUtils.dart';
import 'package:unihub/utils/LandingPageUtils.dart';
import 'package:unihub/constants/Constants.dart' as constants;

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
  bool isBigCircle = false;
  bool firstPage = true;

  var halfLogoUtils = HalfLogoUtils();
  var landingPageUtils = LandingPageUtils();

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      setState(() { isBigCircle = true; });
      Timer(const Duration(seconds: 2), () {
        setState(() { firstPage = false; });
      });
    });


    return Scaffold(
      body: Stack(
        children: [
          Align(
            child: Circle(isBigCircle),
            alignment: Alignment.center,
          ),
          halfLogoUtils.loadHalfLogo(Alignment.topCenter),
          if (firstPage) ... [
            Align(
              child: landingPageUtils.createWelcomeString(username),
              alignment: Alignment.center,
            ),
          ] else ... [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumbers(),
                _buildTasks(),
                _buildIcons()
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.help_outline_rounded, size: 40, color: Colors.white),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 30)),
                Center (
                  child: Container (
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(151, 56), primary: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TabViewController()));
                      },
                      child: Text("Got it!", style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: constants.MAIN_BLUE,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.25),
                          )],)
                      ),
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50)
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTasks() {
    var info1 = 'Evaluate 5 tasks';
    var info2 = 'Complete tasks';
    var info3 = 'Earn tokens';
    var info4 = 'Spend those tokens';

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 75),
        _buildTask(info1),
        _buildTask(info2),
        _buildTask(info3),
        _buildTask(info4),
        const SizedBox(height: 75)
      ],
    );
  }

  Widget _buildTask(String task) {
    return Text(task,
        style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
        )
    );
  }

  Widget _buildNumbers() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 100),
        _buildNumber(1),
        _buildNumber(2),
        _buildNumber(3),
        _buildNumber(4),
        const SizedBox(height: 100)
      ],
    );
  }

  Widget _buildNumber(int num) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4),
          )
        ],
      ),
      width: 40,
      height: 40,
      child: Center(
        child: Text(num.toString(),
            style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: constants.MAIN_BLUE
            )
        ),
      ),
    );
  }

  Widget _buildIcons() {
    var home = const Icon(Icons.home_outlined, size: 50, color: Colors.white,);
    var task = const Icon(Icons.task_outlined, size: 50, color: Colors.white,);
    var wallet = const Icon(Icons.account_balance_wallet_outlined, size: 50, color: Colors.white,);
    var shopping = const Icon(Icons.shopping_basket_outlined, size: 50, color: Colors.white,);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 110),
        home,
        task,
        wallet,
        shopping,
        const SizedBox(height: 110)
      ],
    );
  }
}



class Circle extends StatefulWidget {
  bool checked = false;
  Circle(this.checked, {Key? key}) : super(key: key);
  @override
  CircleState createState() => CircleState();
}

class CircleState extends State<Circle> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 10,
      child: AnimatedContainer(
        width: widget.checked ? 300 : 30,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: constants.PRIMARY_COLOR,
        ),
        child: const SizedBox(height: 100, width: 100,),
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
      ));
  }
}

