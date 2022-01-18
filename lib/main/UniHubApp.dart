import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihub/login/LoginPage.dart';
import 'package:unihub/signin/google/SignInPage.dart';
import 'package:unihub/taskpages/homepage/HomePage.dart';
import 'package:unihub/landingpage/LandingPage.dart';

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
        initialRoute: '/LandingPage',
        routes: {
          '/LandingPage': (context) => const LandingPage(username: username),
          '/LoginPage': (context) => const LoginPage()
        },
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      )
    );
  }

}