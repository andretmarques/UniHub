import 'package:provider/provider.dart';
import 'package:unihub/constants/Constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:unihub/signin/google/SignInPage.dart';
import 'package:unihub/Utils/Utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const utils = Utils();

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
              utils.buildTextLabel("Please login to continue"),
              utils.buildInput(InputType.Email),
              utils.buildInput(InputType.Password),
              Container(width: 350,
                  child:utils.buildTextButtonLabel("Forgot Password?"),
                  alignment: Alignment.centerRight),
              const Padding(padding: EdgeInsets.only(bottom: 50.0)),
              utils.buildButton("LOGIN"),
              Row( children:
                  [utils.buildTextLabel("Don't have an account?"),
                  utils.buildTextButtonLabel('Create a new account')],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center
              ) ,
              const Padding(padding: EdgeInsets.only(bottom: 50.0)),
              utils.buildTextLabel("LOGIN WITH:"),
              Row(children:
                [_buildLogos(AssetType.Facebook),
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
}



