import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/constants/Constants.dart' as constants;
import 'package:unihub/utils/HalfLogoUtils.dart';


class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  var halfLogoUtils = HalfLogoUtils();

  @override
  void dispose() {
    firstNameController.dispose();
    super.dispose();
  }

  void updateUserValue(String name) {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseDatabase.instance.ref().child('users').child(uid!).update({
      "userName": name,
    });
    FirebaseAuth.instance.currentUser?.updateDisplayName(name);
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
              const SizedBox(
                  child: Text(
                    "Update your Display Name",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
              const SizedBox(height: 40),
              SizedBox(
                  height: 100,
                  width: 300,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your display name';
                      }
                      return null;
                    },
                    decoration:
                    const InputDecoration(labelText: 'Display Name'),
                    controller: firstNameController,
                  )
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(151, 56),
                                primary: constants.MAIN_BLUE
                            ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              updateUserValue(firstNameController.text);
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
                  )
              )
            ],
          ),
        )
    );
  }
}
