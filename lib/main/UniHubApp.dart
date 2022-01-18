import 'package:flutter/material.dart';
import 'package:unihub/login/LoginPage.dart';
import 'package:unihub/registerpage/RegisterPage.dart';
import 'package:unihub/taskpages/homepage/HomePage.dart';
import 'package:unihub/landingpage/LandingPage.dart';

class UniHubApp extends StatelessWidget {
  const UniHubApp({Key? key}) : super(key: key);

  // TODO get username
  static const username = "username";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      ),
      initialRoute: '/RegisterPage',
      routes: {
        '/LandingPage': (context) => const LandingPage(username: username),
        '/LoginPage': (context) => const LoginPage(),
        '/RegisterPage': (context) => const RegisterPage()
      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}