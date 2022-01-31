import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unihub/utils/HalfLogoUtils.dart';
import 'package:unihub/constants/Constants.dart' as constants;
import 'package:unihub/tasksList/data/TasksDao.dart';
import 'package:unihub/tasksList/data/Task.dart';



class MyTasksPage extends StatefulWidget {
  MyTasksPage({Key? key,  required this.toggleBackground}) : super(key: key);
  final ToggleCallback toggleBackground;

  final taskDao = TaskDao();

  @override
  State<StatefulWidget> createState() => _MyTasksPageState(toggleBackground: toggleBackground);
}

class _MyTasksPageState extends State<MyTasksPage> {
  _MyTasksPageState ({Key? key, required this.toggleBackground});
  final ToggleCallback toggleBackground;
  var halfLogoUtils = HalfLogoUtils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constants.MAIN_BLUE,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: const Icon(Icons.arrow_back, size: 50, color: Colors.white,), onPressed: () {
                  toggleBackground(false);
                  Navigator.pop(context);
                }),
                loadHalfLogo(),
                const SizedBox(width: 50.0),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height - 150,
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 25,
                  ),
                  Text("My Tasks",
                      style: GoogleFonts.roboto(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(78, 74, 74, 1.0)
                      )
                  ),
                  _getTaskList(),
                ],
              ),
            ),
          ],
        )
    );
  }

  Widget _getTaskList() {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    return Expanded(
      child: FirebaseAnimatedList(
        query: widget.taskDao.getOwnTaskQuery(uid!),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final task = Task.fromJson(json);
          return Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  SizedBox(
                      height: 40,
                      child: MaterialButton(
                          disabledTextColor: Colors.black87,
                          padding: const EdgeInsets.only(left: 18),
                          onPressed: null,
                          child: Wrap(
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [ Text(task.text, style: GoogleFonts.roboto(
                                      fontSize: 22,
                                      color: const Color.fromRGBO(88, 84, 84, 1)
                                  )),
                                    createTaskIcon(task.state),
                                  ]
                              )
                            ],
                          )
                      )
                  ),
                ],
              )
          );
        },
      ),
    );
  }

  Container createTaskIcon(String taskState) {
    String taskLogoStr = "";
    switch (taskState) {
      case "done":
        taskLogoStr = "assets/images/done.svg";
        break;
      case "inProgress":
        taskLogoStr = "assets/images/inProgress.svg";
        break;
      case "toDo":
        taskLogoStr = "assets/images/toDo.svg";
    }

    return Container(
        padding: const EdgeInsets.only(right: 15),
        child:SvgPicture.asset(taskLogoStr,
            height:22,
            width: 22
        ));
  }


  Container loadHalfLogo() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Image.asset(constants.HALF_LOGO, scale: 2)
    );
  }
}
typedef ToggleCallback = dynamic Function(dynamic);