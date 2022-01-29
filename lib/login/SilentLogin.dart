import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unihub/landingpage/LandingPage.dart';
import 'package:unihub/login/LoginPage.dart';

class SilentLogin extends StatelessWidget {
  const SilentLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasData) {
            return const LandingPage();
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something Went wrong!"),);
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}