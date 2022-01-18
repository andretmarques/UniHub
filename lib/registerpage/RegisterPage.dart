import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/Utils/Utils.dart';
import 'package:unihub/constants/Constants.dart' as Constants;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static const utils = Utils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Constants.PRIMARY_COLOR
        ),
        backgroundColor: Colors.transparent,
        elevation: 0
    ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: Image.asset(Constants.HALF_LOGO, scale: 1.5),
                  margin: const EdgeInsets.only(top: 50.0)),
              _buildBlueTextLabel('Create Account'),
              const Padding(padding: EdgeInsets.only(bottom: 10.0)),
              utils.buildTextLabel('Create new account'),
              const Padding(padding: EdgeInsets.only(bottom: 50.0)),
              utils.buildInput(InputType.User),
              utils.buildInput(InputType.Email),
              utils.buildInput(InputType.Password),
              utils.buildInput(InputType.ConfirmPassword),
              utils.buildInput(InputType.CC),
              const Padding(padding: EdgeInsets.only(bottom: 50.0)),
              utils.buildButton("CREATE ACCOUNT"),
              Row(
                  children: [
                    utils.buildTextLabel("Already have an account?"),
                    utils.buildTextButtonLabel('Login', context, 1)
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center),
            ]),
      ),
    );
  }

  Widget _buildBlueTextLabel(String text) {
    return Text(text,
        style: GoogleFonts.roboto(
            color: Constants.PRIMARY_COLOR,
            fontWeight: FontWeight.w700,
            fontSize: 26));
  }
}
