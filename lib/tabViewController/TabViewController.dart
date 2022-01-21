import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/landingpage/LandingPage.dart';
import 'package:unihub/login/LoginPage.dart';
import 'package:unihub/registerpage/RegisterPage.dart';
import 'package:unihub/constants/Constants.dart' as Constants;

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
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: const <Widget>[
            //TODO ALTERAR AS PAGINAS DAS TABS
            RegisterPage(),
            LandingPage(username: "username"),
            LoginPage(),
            LandingPage(username: "username"),
          ],
        ),
      ),
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
}