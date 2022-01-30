import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:unihub/landingpage/LandingPage.dart';
import 'package:unihub/login/LoginPage.dart';
import 'package:unihub/registerpage/IdentityPage.dart';

class SilentLogin extends StatelessWidget {
  const SilentLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: silentLogin(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            log(snapshot.data.toString());
              if(snapshot.data == "no-cc"){
                return const IdentityPage();
              } else {
                return const LandingPage();
              }
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something Went wrong!"),);
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }

  Future<String?> silentLogin() async {
    final user = await FirebaseAuth.instance.currentUser;
    if(user == null){
      return null;
    }
    try {
      final query = FirebaseDatabase.instance.ref().child("users").orderByKey().equalTo(user.uid);
      DataSnapshot snapshot = await query.get();
      if(snapshot.child(user.uid).child("cc").value == null){
        return "no-cc";
      } else {
        return "landing";
      }
    } on FirebaseAuthException catch (e) {
      log(e.code);
      return e.code;
    }
  }
}