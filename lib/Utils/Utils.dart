import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/constants/Constants.dart' as Constants;
import 'package:unihub/registerpage/RegisterPage.dart';
import 'dart:developer';

class Utils extends StatelessWidget {
  const Utils({Key? key}) : super(key: key);

  Widget buildInput(InputType type) {
    Icon icon;
    String textLabel;
    bool obscure;
    var validate;

    switch (type) {
      case InputType.Password:
        icon = const Icon(Icons.lock);
        textLabel = "Password";
        obscure = true;
        validate = validateDefault;
        break;
      case InputType.Email:
        icon = const Icon(Icons.email);
        textLabel = "Email";
        obscure = false;
        validate = validateEmail;
        break;
      case InputType.User:
        icon = const Icon(Icons.person);
        textLabel = "User";
        obscure = false;
        validate = validateDefault;
        break;
      case InputType.ConfirmPassword:
        icon = const Icon(Icons.lock);
        textLabel = "Confirm Password";
        obscure = true;
        validate = validateDefault;
        break;
      case InputType.CC:
        icon = const Icon(Icons.credit_card);
        textLabel = "Identification";
        obscure = false;
        validate = validateCC;
        break;
    }
    return Container(
        width: 350,
        padding: const EdgeInsets.only(top: 20.0),
        child: TextFormField(
          autocorrect: true,
          obscureText: obscure,
          validator: (value) {
            return validate(value);
          },
          decoration: InputDecoration(
            prefixIcon: icon,
            filled: true,
            fillColor: Colors.white70,
            labelText: textLabel,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
          ),
        )
    );
  }

  Widget buildButton(String text, GlobalKey<FormState> key) {
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), fixedSize: const Size(275, 56), primary: Constants.PRIMARY_COLOR);

    return Center (
      child: Container (
      child: ElevatedButton(
        style: style,
        onPressed: () {
          if(key.currentState!.validate()){
            //TODO change from hardcoded buttons
            if (text == "LOGIN") {
              signInEmail("barry.allen@example.com", "SuperSecretPassword!");
            } else if (text == "CREATE ACCOUNT") {
              signUpEmail("barry.allen@example.com", "SuperSecretPassword!", "Barry Allen" , "000000000ZZ4");
            }
          }
        },
        child: Text(text, style: GoogleFonts.roboto(
          color: Colors.white, fontWeight: FontWeight.w900, shadows: <Shadow>[
            const Shadow( offset: Offset(0, 4.0), blurRadius: 4.0,
              color: Color.fromRGBO(0, 0, 0, 0.25),
            )],)
        ),
      ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }

    Widget buildTextButtonLabel(String text, BuildContext context, int i) {
        return TextButton(child: Text(text,
          style: GoogleFonts.roboto(
              color: Constants.PRIMARY_COLOR,
              fontWeight: FontWeight.w400,
              fontSize: 14),
        ),
          onPressed: () {
            if (i == 1) {
              Navigator.pop(context);
            } else if (i == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
            }
          },
        );
      }

  Widget buildTextLabel(String text) {
    return Text(text,
        style: GoogleFonts.roboto(
            color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14)
    );
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  void signInEmail(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      log(e.code);
    }
  }

  void signUpEmail(email, password, name, cc) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password );
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      //TODO add cc
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      log(e.code);
    }
  }

  String? validateDefault(text) {
    return null;
  }

  String? validateEmail(email) {
    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){
      return null;
    }
    return "Invalid email address";
  }

  String? validateCC(String CC) {
    int sum = 0;
    bool secondDigit = false;
    if(CC.length != 12) {
      return "Invalid size for CC";
    }
    CC = CC.toUpperCase();
    if(!RegExp(r"^[A-Z0-9]*$").hasMatch(CC)){
      return "Invalid characters on CC";
    }
    for (int i = CC.length - 1; i >= 0; --i)
    {
      int value = getNumber(CC[i]);
      if (secondDigit) {
        value *= 2;
        if (value > 9) {
          value -= 9;
        }
      }
      sum += value;
      secondDigit = !secondDigit;
    }
    if((sum % 10) == 0){
      return null;
    }
    return "Invalid CC";
  }

  int getNumber(String s){
    try {
      int a = int.parse(s);
      return a;
    } on FormatException catch (e) {
      return s.codeUnitAt(0) - 55;
    }
  }


}

enum InputType {
  Email,
  Password,
  User,
  ConfirmPassword,
  CC
}

enum AssetType {
  Facebook,
  Google
}