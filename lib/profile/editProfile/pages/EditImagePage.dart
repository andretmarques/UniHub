import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/utils/HalfLogoUtils.dart';
import 'package:unihub/constants/Constants.dart' as constants;

class EditImagePage extends StatefulWidget {
  const EditImagePage({Key? key, required this.imageURL}) : super(key: key);
  final String imageURL;

  @override
  // ignore: no_logic_in_create_state
  _EditImagePageState createState() => _EditImagePageState(imageURL: imageURL);
}

class _EditImagePageState extends State<EditImagePage> {
  _EditImagePageState ({Key? key , required this.imageURL});
  String imageURL;
  final _formKey = GlobalKey<FormState>();
  final imageController = TextEditingController();

  var halfLogoUtils = HalfLogoUtils();
  var newImageURL = "";

  void updateImage(String url){
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseDatabase.instance.ref().child('users').child(uid!).update({
      "image": url,
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: const Icon(Icons.arrow_back, size: 50, color: Colors.black,), onPressed: () {Navigator.pop(context);}),
                halfLogoUtils.loadHalfLogo(Alignment.center),
                const SizedBox(width: 50.0),
              ],
            ),
            const SizedBox(height: 25),
            CircleAvatar(
              radius: 75,
              backgroundColor: constants.MAIN_BLUE,
              child: CircleAvatar(
                child: ClipOval(
                  child: Image.network(newImageURL,
                    width: 1000,
                    height: 1000,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      newImageURL = "";
                      return Image.network(imageURL,
                        width: 1000,
                        height: 1000,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                radius: 70,
              ),
            ),
            const SizedBox(height: 35),
            const SizedBox(
                width: 330,
                child: Text(
                  "Change you profile picture",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                    width: 330,
                    child: TextFormField(
                      // Handles Form Validation for First Name
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the URL for your profile picture';
                        }
                        return null;
                      },
                      decoration:
                      const InputDecoration(labelText: 'URL'),
                      controller: imageController,
                    )
                )
            ),
            Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 15),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 330,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(151, 56),
                            primary: constants.MAIN_BLUE
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              newImageURL = imageController.text;
                            });
                          }
                        },
                        child: Text("Test",
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            )
                        ),
                      ),
                    )
                )
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 330,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(151, 56),
                        primary: constants.MAIN_BLUE
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate() && newImageURL != "") {
                        updateImage(newImageURL);
                        Navigator.pop(context);
                      }
                      },
                    child: Text("Update",
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        )
                    ),
                  ),
                )
            ),
          ],
        ),
      )
    );
  }
}
