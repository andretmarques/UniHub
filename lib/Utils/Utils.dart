import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum InputType {
  Email,
  Password,
  User,
  ConfirmPassword

}

enum AssetType {
  Facebook,
  Google
}


class Utils extends StatelessWidget {
  const Utils({Key? key}) : super(key: key);

  Widget buildInput(InputType type) {
    Icon icon;
    String textLabel;

    switch (type) {
      case InputType.Password:
        icon = const Icon(Icons.lock);
        textLabel = "Password";
        break;
      case InputType.Email:
        icon = const Icon(Icons.email);
        textLabel = "Email";
        break;
      case InputType.User:
        icon = const Icon(Icons.person);
        textLabel = "User";
        break;
      case InputType.ConfirmPassword:
        icon = const Icon(Icons.lock);
        textLabel = "Confirm Password";
        break;
    }
    return Container(
        width: 350,
        padding: const EdgeInsets.only(top: 20.0),
        child: TextField(
          autocorrect: true,
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

  Widget buildButton(String text) {
      final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), fixedSize: const Size(275, 56), primary: const Color.fromRGBO(88, 136, 204, 1));

      return Center (
        child: Container (
          child: ElevatedButton(
            style: style,
            onPressed: () {},
            child: Text(text, style: GoogleFonts.roboto(
                color: Colors.white, fontWeight: FontWeight.w900, shadows: <Shadow>[
              const Shadow( offset: Offset(0, 4.0),
                blurRadius: 4.0,
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

    Widget buildTextButtonLabel(String text) {
      return TextButton(child: Text(text,
        style: GoogleFonts.roboto(
            color: const Color.fromRGBO(88, 136, 204, 1),
            fontWeight: FontWeight.w400,
            fontSize: 14),
    ),
        onPressed: () {}
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
}