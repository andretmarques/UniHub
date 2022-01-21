import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/landingpage/LandingPage.dart';
import 'package:unihub/login/LoginPage.dart';
import 'package:unihub/constants/Constants.dart' as Constants;
import 'package:unihub/votingPage/VotingPage.dart';

import 'BazeierClipper.dart';

class TabViewController extends StatefulWidget {
  const TabViewController({Key? key}) : super(key: key);

  @override
  State<TabViewController> createState() => _TabViewControllerState();
}

class _TabViewControllerState extends State<TabViewController> {

  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.52;

    return Scaffold(
        body: Stack(
            children: <Widget>[
              ClipPath(child:
              Container(color: Constants.PURPLE, height: height), clipper: BezierClipper()),
              Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 50.0)),
                    Stack(
                      children: [Row(
                        children:
                        [const Padding(padding: EdgeInsets.only(right: 30.0)),
                          _buildLogos("HELP"),
                          const Padding(padding: EdgeInsets.only(right: 80.0)),
                          loadHalfLogo(),
                          const Padding(padding: EdgeInsets.only(right: 70.0)),
                          _buildLogos("BELL")],
                      )]
                    )]
              ),
              SizedBox.expand(
                child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {setState(() => _currentIndex = index);},
                    children:
                    const <Widget>[
                      LandingPage(username: "username"),
                      LoginPage(),
                      LandingPage(username: "username"),
                      VotingPage(),
                    ])
              )
    ]),

      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        iconSize: 32,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Home', style: GoogleFonts.roboto(fontSize: 16)),
              icon: const Icon(Icons.home_outlined),
              activeColor: Constants.LIGHT_PURPLE,
              inactiveColor: Colors.black,
            textAlign: TextAlign.center

          ),
          BottomNavyBarItem(
              title: Text('Tasks', style: GoogleFonts.roboto(fontSize: 16)),
              icon: const Icon(Icons.task_outlined),
              activeColor: Constants.LIGHT_PINK,
              inactiveColor: Colors.black,
            textAlign: TextAlign.center

          ),
          BottomNavyBarItem(
              title: Text('Ranks', style: GoogleFonts.roboto(fontSize: 16)),
              icon: const Icon(Icons.leaderboard_outlined),
              activeColor: Constants.LIGHT_YELLOW,
              inactiveColor: Colors.black,
            textAlign: TextAlign.center

          ),
          BottomNavyBarItem(
              title: Text('Profile', style: GoogleFonts.roboto(fontSize: 16)),
              icon: const Icon(Icons.person_outline),
              activeColor: Constants.LIGHT_BLUE,
              inactiveColor: Colors.black,
            textAlign: TextAlign.center


          ),
        ],
      ),
    );
  }
  Container loadHalfLogo() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Image.asset(Constants.HALF_LOGO, scale: 2)
    );
  }

  Widget _buildLogos(String type) {
    var help = const Icon(Icons.help_outline_rounded, size: 40, color: Colors.white,);

    var bell = const Icon(Icons.notifications_none_rounded, size: 40, color: Colors.white,);

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
}