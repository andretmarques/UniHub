import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/landingpage/LandingPage.dart';
import 'package:unihub/login/LoginPage.dart';
import 'package:unihub/constants/Constants.dart' as Constants;
import 'package:unihub/registerpage/IdentityPage.dart';
import 'package:unihub/tabViewController/CustomNavBar.dart';
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
        body: SafeArea(
          child: Stack(
              children: <Widget>[
                ClipPath(child:
                Container(color: Constants.PURPLE, height: height), clipper: BezierClipper()),
                Column(
                    children: [
                      //const Padding(padding: EdgeInsets.only(top: 25.0)),
                      Stack(
                          children: [Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:
                            [//const Padding(padding: EdgeInsets.only(right: 30.0)),
                              _buildLogos("HELP"),
                              //const Padding(padding: EdgeInsets.only(right: 80.0)),
                              loadHalfLogo(),
                              //const Padding(padding: EdgeInsets.only(right: 70.0)),
                              _buildLogos("BELL")],
                          )]
                      )]
                ),
                SizedBox.expand(
                    child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (index) {setState(() => _currentIndex = index);},
                        children:
                        const <Widget>[
                          VotingPage(),
                          LandingPage(username: "username"),
                          LoginPage(),
                          IdentityPage()
                        ])
                )
              ]),
        ),

      bottomNavigationBar: CustomNavBar(
        selectedIndex: _currentIndex,
        iconSize: 32,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <CustomNavBarItem>[
          CustomNavBarItem(
              title: Text('Home', style: GoogleFonts.roboto(fontSize: 16)),
              icon: const Icon(Icons.home_outlined),
              activeColor: Constants.LIGHT_PURPLE,
              inactiveColor: Colors.black,
              textAlign: TextAlign.center
          ),
          CustomNavBarItem(
              title: Text('Tasks', style: GoogleFonts.roboto(fontSize: 16)),
              icon: const Icon(Icons.task_outlined),
              activeColor: Constants.LIGHT_PINK,
              inactiveColor: Colors.black,
              textAlign: TextAlign.center
          ),
          CustomNavBarItem(
              title: Text('Ranks', style: GoogleFonts.roboto(fontSize: 16)),
              icon: const Icon(Icons.leaderboard_outlined),
              activeColor: Constants.LIGHT_YELLOW,
              inactiveColor: Colors.black,
              textAlign: TextAlign.center
          ),
          CustomNavBarItem(
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

    var icon;

    switch (type) {
      case "HELP":
        icon = help;
        break;
      case "BELL":
        icon = bell;
        break;
    }

    return Center(
        child: Container(
            height: 80,
            alignment: Alignment.center,
            child: IconButton(
                icon: icon,
                onPressed: () {}
                )
        )
    );
  }
}