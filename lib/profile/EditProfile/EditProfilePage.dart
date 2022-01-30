import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/profile/EditProfile/pages/EditImagePage.dart';
import 'package:unihub/profile/EditProfile/pages/EditNamePage.dart';
import 'package:unihub/profile/EditProfile/widgets/display_image_widget.dart';
import 'package:unihub/userData/User.dart' as my;
import 'package:unihub/utils/HalfLogoUtils.dart';
import 'package:unihub/constants/Constants.dart' as constants;



class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var halfLogoUtils = HalfLogoUtils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: getLoggedUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData){
              my.User user = (snapshot.data) as my.User;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: const Icon(Icons.arrow_back, size: 50, color: Colors.black,), onPressed: () {Navigator.pop(context);}),
                      halfLogoUtils.loadHalfLogo(Alignment.center),
                      const SizedBox(width: 50.0),
                    ],
                  ),
                  Text("Your Profile",
                      style: GoogleFonts.roboto(
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                          color: const Color.fromRGBO(104, 102, 102, 1.0)
                      )
                  ),
                  const SizedBox(height: 50,),
                  InkWell(
                      onTap: () {
                        navigateSecondPage(EditImagePage(imageURL: user.image));
                      },
                      child: DisplayImage(
                        imagePath: user.image,
                        onPressed: () {},
                      )
                  ),
                  const SizedBox(height: 25,),
                  buildUserInfoDisplay(user.name, 'Display Name', const EditNameFormPage()),
                ],
              );
            }
            return Container();
          },
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


  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ))),
                  child: Row(
                      children: [
                        Expanded(
                            child: TextButton(
                                onPressed: () {
                                  navigateSecondPage(editPage);
                                  },
                                child: Text(
                                    getValue,
                                    style: GoogleFonts.roboto(
                                        color: constants.MAIN_BLUE, fontWeight: FontWeight.bold, fontSize: 16)
                                )
                            )
                        ),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey,
                          size: 40.0,
                        )
                      ]
                  )
              )
            ],
          )
      );


  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}