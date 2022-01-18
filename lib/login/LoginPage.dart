import 'package:provider/provider.dart';
import 'package:unihub/constants/Constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:unihub/signin/google/SignInPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

enum InputType {
  Email,
  Password

}

enum AssetType {
  Facebook,
  Google
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: Image.asset(Constants.FULL_LOGO, scale: 2),
                  margin: const EdgeInsets.all(50.0)),
              //const Padding(padding: EdgeInsets.only(bottom: 30.0)),
              _buildTextLabel("Please login to continue"),
              _buildInput(InputType.Email),
              _buildInput(InputType.Password),
              Container(width: 350, child:_buildTextButtonLabel("Forgot Password?"), alignment: Alignment.centerRight),
              const Padding(padding: EdgeInsets.only(bottom: 50.0)),
              _buildButton("LOGIN"),
              Row( children: [_buildTextLabel("Don't have an account?"),
                _buildTextButtonLabel('Create a new account')],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center
              ) ,
              const Padding(padding: EdgeInsets.only(bottom: 50.0)),
              _buildTextLabel("LOGIN WITH:"),
              Row(children: [
                _buildLogos(AssetType.Facebook),
                _buildLogos(AssetType.Google)],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center
              )
            ]),
      ),
    );
  }

  Widget _buildLogos(AssetType type) {
    var fbIcon = 'assets/images/facebook.svg';

    var googleIcon = 'assets/images/google.svg';

    var icon = type == AssetType.Facebook ? fbIcon : googleIcon;

    return SimpleShadow(
      child: IconButton(
          icon: SvgPicture.asset(icon,
              height:49,
              width: 49
          ),
          onPressed: () {
            final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.googleLogin();
          }
      ),
    );
  }

  Widget _buildInput(InputType type) {
    final icon = type == InputType.Email ? const Icon(Icons.email) : const Icon(Icons.lock);
    final textLabel = type == InputType.Email ? "Email" : "Password";
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

  Widget _buildTextLabel(String text) {
    return Text(text,
        style: GoogleFonts.roboto(
            color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14)
    );
  }

  Widget _buildTextButtonLabel(String text) {
    return TextButton(child: Text(text,
        style: GoogleFonts.roboto(
            color: const Color.fromRGBO(88, 136, 204, 1),
            fontWeight: FontWeight.w400,
            fontSize: 14)
    ),
        onPressed: () {}
    );
  }

  Widget _buildButton(String text) {
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), fixedSize: const Size(275, 56), primary: const Color.fromRGBO(88, 136, 204, 1));

    return Center (
      child: Container (
        child: ElevatedButton(
          style: style,
          onPressed: () {},
          child: Text(text, style: GoogleFonts.roboto(
              color: Colors.white, fontWeight: FontWeight.w900)
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
}



