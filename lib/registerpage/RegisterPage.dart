import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/utils/Utils.dart';
import 'package:unihub/constants/Constants.dart' as Constants;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static const utils = Utils();
  final GlobalKey<FormBuilderState> _registerForm = GlobalKey<FormBuilderState>();

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
              Image.asset(Constants.HALF_LOGO, scale: 1.5),
              _buildBlueTextLabel('Create Account'),
              const Padding(padding: EdgeInsets.only(bottom: 10.0)),
              utils.buildTextLabel('Create new account'),
              const Padding(padding: EdgeInsets.only(bottom: 20.0)),
              FormBuilder(
                  key: _registerForm,
                  child: Column(
                      children: [
                        utils.buildInput(FormInputType.User),
                        utils.buildInput(FormInputType.Email),
                        utils.buildInput(FormInputType.Password),
                        utils.buildInput(FormInputType.ConfirmPassword),
                        const Padding(padding: EdgeInsets.only(bottom: 50.0)),
                        utils.buildButton("NEXT", _registerForm, context, false),
                  ])
              ),
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
