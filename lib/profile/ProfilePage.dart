import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/constants/Constants.dart' as constants;
import 'EditProfile/EditProfilePage.dart';
import 'package:unihub/userData/User.dart' as my;




class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: getLoggedUser(),
          builder: (context, snapshot) {
            my.User user = my.User("", 0, "", false);
            if (snapshot.hasData){
              user = (snapshot.data) as my.User;
            }
            return Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Padding(padding: EdgeInsets.only(bottom: 120)),
                        buildEditProfile(context),
                        const Padding(padding: EdgeInsets.only(bottom: 5)),
                        buildLogOut(context),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(right: 15))
                  ],
                ),
                if (snapshot.hasData) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 25)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(bottom: 90)),
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.image),
                            radius: 38,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 5)),
                        Text(user.name,
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                        Text(user.isTeacher ? "IST Teacher" : "IST Student",
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ],
                Column(
                  children: [
                    Row(
                        children: [
                          buildButtonContainer("WALLET"),
                          const Padding(padding: EdgeInsets.only(right: 25.0)),
                          buildButtonContainer("SHOPPING")
                        ],
                        mainAxisAlignment: MainAxisAlignment.center
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 20.0)),
                    Row(
                        children: [
                          buildButtonContainer("STATISTICS"),
                          const Padding(padding: EdgeInsets.only(right: 25.0)),
                          buildButtonContainer("TASKS")
                        ],
                        mainAxisAlignment: MainAxisAlignment.center
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 30.0))
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ],);

          },
        )
    );
  }

  Widget buildButtonContainer(String type) {
    var wallet = const Icon(Icons.account_balance_wallet_outlined, size: 60, color: constants.LOGO_GREY,);
    var shopping = const Icon(Icons.shopping_basket_outlined, size: 60, color: constants.LOGO_GREY,);
    var statistics = const Icon(Icons.leaderboard_outlined, size: 60, color: constants.LOGO_GREY,);
    var tasks = const Icon(Icons.sticky_note_2_outlined, size: 60, color: constants.LOGO_GREY,);

    var icon;

    switch (type) {
      case "WALLET":
        icon = wallet;
        break;
      case "SHOPPING":
        icon = shopping;
        break;
      case "STATISTICS":
        icon = statistics;
        break;
      case "TASKS":
        icon = tasks;
        break;
    }

    return Center(
        child: InkWell(
          onTap: () {},
          child: Ink(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromRGBO(170, 170, 170, 1)
                ),
                borderRadius: BorderRadius.circular(20),
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    icon,
                    Text(type)
                  ]
              )
          ),
        )
    );
  }

  Future<my.User?> getLoggedUser() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    final query = FirebaseDatabase.instance.ref().child('users').orderByKey().equalTo(uid);
    try {
      DataSnapshot snapshot = await query.get();
      final json = snapshot.value as Map<dynamic, dynamic>;
      final user = my.User.fromJson(json[uid]);
      return user;
    } on FirebaseAuthException catch (e) {
      log(e.code);
      return null;
    }
  }

  Widget buildLogOut(BuildContext context) {
    var logOutIcon = const Icon(Icons.exit_to_app_outlined, size: 20, color: Colors.white);

    return InkWell(
          onTap: () {
            FirebaseAuth.instance.signOut();
            Navigator.popAndPushNamed(context, "/LoginPage");
          },
          child: Ink(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    logOutIcon,
                    const Padding(padding: EdgeInsets.only(right: 5)),
                    Text("log out",
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 10)),
                  ]
              )
          ),
    );
  }

  Widget buildEditProfile(BuildContext context) {
    var editLogo = const Icon(Icons.edit_outlined, size: 20, color: constants.MAIN_BLUE);

    return TextButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(4),
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 10, right: 10)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(
                color: Color.fromRGBO(0, 93, 222, 1.0))
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            editLogo,
            const Padding(padding: EdgeInsets.only(right: 5)),
            Text("Edit Profile",
                style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: constants.MAIN_BLUE
                ),
            ),
          ],
      ),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => const EditProfilePage()));
      },
    );
  }
}