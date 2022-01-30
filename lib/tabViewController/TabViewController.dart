import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:unihub/faq/FaqPage.dart';
import 'package:unihub/constants/Constants.dart' as Constants;
import 'package:unihub/profile/ProfilePage.dart';
import 'package:unihub/tabViewController/CustomNavBar.dart';
import 'package:unihub/tasksList/TaskList.dart';
import 'package:unihub/votingPage/VotingPage.dart';

import 'BazeierClipper.dart';

class TabViewController extends StatefulWidget {
  const TabViewController({Key? key}) : super(key: key);

  @override
  State<TabViewController> createState() => _TabViewControllerState();
}

class _TabViewControllerState extends State<TabViewController> with TickerProviderStateMixin {

  int _currentIndex = 0;
  double _heightMul = 0.5;
  late PageController _pageController;
  bool isFinalState = false;
  late AnimationController _animcontroller;
  late AnimationController _colorcontroller;
  late Animation<double> _animation;
  late ColorTween _finalTween;
  late Animation _finalAnimation;
  final List<Color> _colors = [Constants.MAIN_PURPLE, Constants.MAIN_PINK, Constants.MAIN_YELLOW, Constants.MAIN_BLUE];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animcontroller =  AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _colorcontroller =  AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    _finalTween = ColorTween(begin: _colors[0], end: _colors[1]);
    _finalAnimation = _finalTween.animate(_colorcontroller)
      ..addListener(() {
          setState(() {});
        });
    _animation = CurvedAnimation(
      parent: _animcontroller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
  }

  _toggle(finalState){
    setState(() {
      if(finalState != isFinalState){
        isFinalState = finalState;
        if(!isFinalState) {
          _animcontroller.reverse(from : 1.0);
        } else {
          _animcontroller.forward(from: 0.0);
        }
      }
    });
  }

  changeColor(equals, next, current){
    setState(() {
      if (!equals){
        _finalTween.begin = _colors[current];
        _colorcontroller.reset();
        _finalTween.end = _colors[next];
        _colorcontroller.forward();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animcontroller.dispose();
    _colorcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
          child: Stack(
              children: <Widget>[
                SimpleShadow(
                    child: AnimatedBuilder(
                          animation: _animcontroller,
                          builder: (context, anim){
                            final double progress = _animation.value;
                            final double height = MediaQuery.of(context).size.height;
                            return ClipPath(
                                child: Container(
                                    color: _finalAnimation.value,
                                    height: height),
                                clipper: BezierClipper(progress, _heightMul)
                            );
                      },
                    ),
                    offset: const Offset(0, 4),
                    opacity: 0.25,
                ),
                SizedBox.expand(
                    child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (index) {
                        },
                        children:
                        [
                          VotingPage(),
                          TaskList(),
                          VotingPage(),
                          ProfilePage(),
                        ])
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:
                  [
                    _buildLogos("HELP", context),
                    loadHalfLogo(),
                    _buildLogos("BELL", context),
                  ],
                )
              ]),
        ),

      bottomNavigationBar: CustomNavBar(
        selectedIndex: _currentIndex,
        iconSize: 32,
        onItemSelected: (index) {
          changeColor(_currentIndex == index, index, _currentIndex);
          setState(() => _currentIndex = index);
          switch(index){
            case 0:
              _heightMul = 0.5;
              _toggle(false);
              break;
            case 1:
              _heightMul = 0.2;
              _toggle(false);
              break;
            case 2:
              _heightMul = 0.8;
              _toggle(true);
              break;
            case 3:
              _heightMul = 0.38;
              _toggle(false);
              break;
          }
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

  Widget _buildLogos(String type, BuildContext context) {
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

    return IconButton(
        icon: icon,
        onPressed: () {
          if(type == "HELP"){
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => const FaqPage()));
          } else {
            _toggle(!isFinalState);
          }
        }
    );
  }
}