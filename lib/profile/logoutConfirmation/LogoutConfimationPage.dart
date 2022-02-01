import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/utils/HalfLogoUtils.dart';
import 'package:unihub/constants/Constants.dart' as constants;
import 'package:unihub/userData/User.dart' as my;



class LogoutConfirmationPage extends StatefulWidget {
  const LogoutConfirmationPage({Key? key, required this.user, required this.toggleBackground}) : super(key: key);
  final ToggleCallback toggleBackground;
  final my.User user;


  @override
  State<StatefulWidget> createState() => _LogoutConfirmationPageState(toggleBackground: toggleBackground, user: user);
}

class _LogoutConfirmationPageState extends State<LogoutConfirmationPage> {
  _LogoutConfirmationPageState ({Key? key, required this.user, required this.toggleBackground});
  final ToggleCallback toggleBackground;
  final my.User user;
  var halfLogoUtils = HalfLogoUtils();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constants.MAIN_BLUE,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: const Icon(Icons.arrow_back, size: 50, color: Colors.white,), onPressed: () {
                  toggleBackground(false);
                  Navigator.pop(context);
                }),
                loadHalfLogo(),
                const SizedBox(width: 50.0),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 20),
              height: MediaQuery.of(context).size.height - 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color.fromRGBO(170, 170, 170, 1.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 25,
                  ),
                  Text("Are you sure you want to log out?",
                      style: GoogleFonts.roboto(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(53, 53, 53, 1.0)
                      )
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 75, bottom: 75, left: 15),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 1.0,
                            color: Color.fromRGBO(170, 170, 170, 1.0)
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: constants.MAIN_BLUE,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.image),
                            radius: 38,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(right: 5)),
                        Text(user.name,
                          style: GoogleFonts.roboto(
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              color: const Color.fromRGBO(65, 65, 65, 1.0)
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 82,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                            padding: const EdgeInsets.only(),
                            child: Container(
                              height: 82,
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                      width: 1.0,
                                      color: Colors.black
                                  ),
                                ),
                              ),
                              child: _buildButtonRow(false),
                              width: MediaQuery.of(context).size.width/2.25,
                            ),
                            onPressed: (){
                              toggleBackground(false);
                              Navigator.pop(context);
                            }
                        ),
                        MaterialButton(
                            padding: const EdgeInsets.only(),
                            child: Container(
                              height: 82,
                              child: _buildButtonRow(true),
                              width: MediaQuery.of(context).size.width/2.25,
                            ),
                            onPressed: (){
                              FirebaseAuth.instance.signOut();
                              Navigator.popAndPushNamed(context, "/LoginPage");
                            }
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }

  Row _buildButtonRow(bool y){
    var text = y ? "YES" : "NO";
    var svg = y ? "assets/images/yes.svg" : "assets/images/no.svg";

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text,
          style: GoogleFonts.roboto(
              fontSize: 23,
              fontWeight: FontWeight.normal,
              color: const Color.fromRGBO(95, 89, 89, 1.0)
          ),
        ),
        const SizedBox(width: 10),
        SvgPicture.asset(svg,
            height:20, width: 20)
      ],
    );
  }

  Container loadHalfLogo() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Image.asset(constants.HALF_LOGO, scale: 2)
    );
  }
}
typedef ToggleCallback = dynamic Function(dynamic);