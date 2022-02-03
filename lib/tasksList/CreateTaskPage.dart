import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:unihub/profile/shopping/BuyConfirmationPage.dart';
import 'package:unihub/profile/wallet/transactions/TransactionsDao.dart';
import 'package:unihub/utils/HalfLogoUtils.dart';
import 'package:unihub/constants/Constants.dart' as constants;



class CreateTaskPage extends StatefulWidget {
  CreateTaskPage({Key? key,  required this.toggleBackground}) : super(key: key);
  final ToggleCallback toggleBackground;


  @override
  State<StatefulWidget> createState() => _CreateTaskPageState(toggleBackground: toggleBackground);
}

class TaskState
{
  String label;
  Color color;
  TaskState(this.label, this.color);
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  _CreateTaskPageState ({Key? key, required this.toggleBackground});
  final ToggleCallback toggleBackground;
  var halfLogoUtils = HalfLogoUtils();
  var tokens = "Loading...";
  int selectedIndex = 0;

  final List<TaskState> _chipsList = [
    TaskState("To Do", Colors.green),
    TaskState("In Progress", Colors.blueGrey),
    TaskState("Done", Colors.blueGrey)
  ];

  final states = ["toDO", "inProgress", "done"];

  final _formKey = GlobalKey<FormState>();
  final descController = TextEditingController();
  final imageController = TextEditingController();
  final locationController = TextEditingController();
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var chips = _buildStateForm();
    return Scaffold(
        backgroundColor: constants.MAIN_PINK,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: const Icon(Icons.arrow_back, size: 50, color: Colors.white,), onPressed: () {
                    toggleBackground(false);
                    Navigator.pop(context);
                  }),
                  halfLogoUtils.loadHalfLogo(Alignment.center),
                  const SizedBox(width: 50.0),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height - 240,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color.fromRGBO(170, 170, 170, 1.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 15),
                          const SizedBox(
                              child: Text(
                                "Create a task",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                              height: 60,
                              width: 300,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the title';
                                  }
                                  return null;
                                },
                                decoration:
                                const InputDecoration(labelText: 'Title'),
                                controller: titleController,
                              )
                          ),
                          SizedBox(
                              height: 60,
                              width: 300,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the image URL';
                                  }
                                  return null;
                                },
                                decoration:
                                const InputDecoration(labelText: 'Image URL'),
                                controller: imageController,
                              )
                          ),
                          SizedBox(
                              height: 60,
                              width: 300,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the location';
                                  }
                                  return null;
                                },
                                decoration:
                                const InputDecoration(labelText: 'Location'),
                                controller: locationController,
                              )
                          ),
                          SizedBox(
                              height: 60,
                              width: 300,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the description';
                                  }
                                  return null;
                                },
                                decoration:
                                const InputDecoration(labelText: 'Description'),
                                controller: descController,
                              )
                          ),
                          Wrap(spacing: 6,
                              direction: Axis.horizontal,
                              children: chips.chips),
                          Padding(
                              padding: const EdgeInsets.only(top: 30),
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
                                          applyTask(states[selectedIndex], titleController.value.text, locationController.value.text, descController.value.text, imageController.value.text);
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
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }

  Future<void> applyTask(String state, String title, String local, String desc, String image) async {
    final DatabaseReference _tasksRef = FirebaseDatabase.instance.ref().child('tasks');
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    _tasksRef.push().set({
      "date": formattedDate,
      "owner": uid,
      "state": state,
      "title": title,
      "upvotes" : 0,
      "localization" : local,
      "description" : desc,
      "image" : image
    });
  }

  FormatResult _buildStateForm () {
    List<Widget> chips = [];
    for (int i=0; i< _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left:10, right: 5),
        child: ChoiceChip(
          label: Text(_chipsList[i].label, style: GoogleFonts.roboto(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20)),
          selected: selectedIndex == i,
          onSelected: (bool value)
          {
            setState(() {
              selectedIndex = i;
            });
          },
          shadowColor: Colors.grey,
          selectedShadowColor: Colors.amberAccent,
          selectedColor: constants.MAIN_BLUE,
          elevation: 3,
          backgroundColor: Colors.black38,
        ),
      );
      chips.add(item);
    }
    return FormatResult(chips, selectedIndex == 0);
  }

}
class FormatResult {
  List<Widget> chips;
  bool isTeacher;
  FormatResult(this.chips, this.isTeacher);
}

typedef ToggleCallback = dynamic Function(dynamic);