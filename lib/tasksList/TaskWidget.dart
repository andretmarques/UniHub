import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TaskWidget extends StatelessWidget {
  final String taskName;
  final String taskState;

  const TaskWidget(this.taskName, this.taskState);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 1, top: 5, right: 1, bottom: 13),
        child: Column(
          children: [
            Container(
              height: 90,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4.0,
                          offset: Offset(0, 4.0)),
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white),
                child: MaterialButton(
                    disabledTextColor: Colors.black87,
                    padding: EdgeInsets.only(left: 18),
                    onPressed: null,
                    child: Wrap(
                      children: <Widget>[
                        Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [ Text(taskName, style: GoogleFonts.roboto(
                                  fontSize: 24,
                                  color: const Color.fromRGBO(88, 84, 84, 1)
                              )),
                                createTaskIcon(taskState)
                              ]
                          )
                      ],
                    ))),
          ],
        ));
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
}
