import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/constants/Constants.dart' as Constants;
import 'package:unihub/registerpage/IdentityPage.dart';
import 'package:unihub/registerpage/RegisterPage.dart';
import 'dart:developer';

class Utils extends StatelessWidget {
  const Utils({Key? key}) : super(key: key);

  Widget buildInput(FormInputType type) {
    Icon icon;
    String textLabel;
    String name;
    bool obscure;
    var validate;

    switch (type) {
      case FormInputType.Password:
        icon = const Icon(Icons.lock);
        textLabel = "Password";
        obscure = true;
        validate = validateDefault;
        name = "pass";
        break;
      case FormInputType.Email:
        icon = const Icon(Icons.email);
        textLabel = "Email";
        obscure = false;
        validate = validateEmail;
        name = "email";
        break;
      case FormInputType.User:
        icon = const Icon(Icons.person);
        textLabel = "User";
        obscure = false;
        validate = validateDefault;
        name = "user";
        break;
      case FormInputType.ConfirmPassword:
        icon = const Icon(Icons.lock);
        textLabel = "Confirm Password";
        obscure = true;
        validate = validateDefault;
        name = "pass2";
        break;
      case FormInputType.CC:
        icon = const Icon(Icons.credit_card);
        textLabel = "Identification";
        obscure = false;
        validate = validateCC;
        name = "cc";
        break;
    }
    return Container(
        width: 350,
        padding: const EdgeInsets.only(top: 20.0),
        child: FormBuilderTextField(
          name: name,
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

  Widget buildButton(String text, GlobalKey<FormBuilderState> key, BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), fixedSize: const Size(275, 56), primary: Constants.PRIMARY_COLOR);

    return Center (
      child: Container (
      child: ElevatedButton(
        style: style,
        onPressed: () {
          if(key.currentState!.saveAndValidate()){
            final formData = key.currentState?.value;
            
            //TODO change from hardcoded buttons
            if (text == "LOGIN") {
              Future<String?> ret = signInEmail(formData!["email"], formData["pass"]);
              ret.then((value) {
                if (value == 'user-not-found') {
                  key.currentState?.invalidateField(name: 'email', errorText: 'User not found');
                  return;
                } else if (value == 'wrong-password') {
                  key.currentState?.invalidateField(name: 'pass', errorText: 'Wrong password');
                  return;
                }
                //TODO entrar na Landing Page
              });

            } else if (text == "NEXT") {

              if (formData!["pass"] != formData["pass2"]){
                key.currentState?.invalidateField(name: 'pass2', errorText: 'Passwords must match');
                return;
              }
              Future<String?> ret = signUpEmail(formData["email"], formData["pass"], formData["user"] , formData["cc"]);

              ret.then((value) {
                if (value == 'weak-password') {
                  key.currentState?.invalidateField(name: 'pass', errorText: 'Passwords is too weak');
                  return;
                } else if (value == 'email-already-in-use') {
                  key.currentState?.invalidateField(name: 'email', errorText: 'Email already in use');
                  return;
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IdentityPage(formKey: key,)));
              });
            }
            else if (text == "CREATE") {
              //TODO entrar na Landing Page
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

  Future<String?> signInEmail(email, password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return null;
    } on FirebaseAuthException catch (e) {
      log(e.code);
      return e.code;
    }
  }

  Future<String?> signUpEmail(email, password, name, cc) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password );
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      final ref = FirebaseDatabase.instance.ref("users");
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      ref.child(uid!).set({
        "cc": cc,
        "isTeacher": false,
        "tokens": 999,
      });
      return null;
    } on FirebaseAuthException catch (e) {
      log(e.code);
      return e.code;
    }
  }

  String? validateDefault(String? text) {
    if (text == null || text.isEmpty){
      return "Field cannot be empty";
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty){
      return "Field cannot be empty";
    }
    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){
      return null;
    }
    return "Invalid email address";
  }

  String? validateCC(String? cc) {
    int sum = 0;
    bool secondDigit = false;
    if (cc == null || cc.isEmpty){
      return "Field cannot be empty";
    }
    cc = cc.replaceAll(' ', '');
    if(cc.length != 12) {
      return "Invalid size for CC";
    }
    cc = cc.toUpperCase();
    if(!RegExp(r"^[A-Z0-9]*$").hasMatch(cc)){
      return "Invalid characters on CC";
    }
    for (int i = cc.length - 1; i >= 0; --i)
    {
      int value = getNumber(cc[i]);
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
      final ref = FirebaseDatabase.instance.ref();
      Query query = ref.child("users").orderByChild("cc").equalTo(cc);
      //todo query
      return null;
    }
    return "Invalid CC";
  }

  int getNumber(String s){
    try {
      int a = int.parse(s);
      return a;
    } on FormatException {
      return s.codeUnitAt(0) - 55;
    }
  }


}

enum FormInputType {
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