import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihub/login/LoginPage.dart';
import 'package:unihub/registerpage/IdentityPage.dart';
import 'package:unihub/landingpage/LandingPage.dart';
import 'package:unihub/login/SilentLogin.dart';
import 'package:unihub/signin/google/SignInPage.dart';
import 'package:page_transition/page_transition.dart';

class UniHubApp extends StatelessWidget {


  // TODO get username
  static const username = "username";
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child:MaterialApp(
        title: 'UniHub',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: firebase,
          builder: (context, snapshot) {
            if(snapshot.hasError) {
              print('You Have an error! ${snapshot.error.toString()}');
              return const Text('Something Went Wrong!');
            } else if (snapshot.hasData) {
              return AnimatedSplashScreen(splash: 'assets/images/half_logo.png',
                splashIconSize: MediaQuery.of(context).size.width - 120,
                pageTransitionType: PageTransitionType.bottomToTop,
                duration: 1000, nextScreen: const SilentLogin(),
              );
            }
            else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        // initialRoute: '/LoginPage',
        routes: {
           '/LandingPage': (context) => const LandingPage(username: username),
           '/LoginPage': (context) => const LoginPage()
        },

      )
    );
  }

}
