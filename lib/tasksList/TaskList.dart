import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'TaskWidget.dart';
import 'package:flutter/material.dart';
import 'data/Task.dart';
import 'data/TasksDao.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class TaskListState extends State<TaskList> {
  final ScrollController _scrollController = ScrollController();
  var dropdownValue = "All Tasks";

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToBottom());

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 200)),
            createDropDown(),
            _getTaskList(),
          ]
        ),
      ),
    );
  }

  Widget _getTaskList() {
    return Expanded(
      child: FirebaseAnimatedList(
        reverse: true,
        controller: _scrollController,
        query: widget.taskDao.getTaskQuery(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final task = Task.fromJson(json);
          return TaskWidget(task.text, task.state);
        },
      ),
    );
  }

  DropdownButton createDropDown() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: GoogleFonts.roboto(
          fontSize: 21,
          color: const Color.fromRGBO(88, 84, 84, 1)
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['All Tasks', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  List createTaskListIcon() {
    var dropDown = [];
    var done = Container(
        padding: const EdgeInsets.only(right: 15),
        child:SvgPicture.asset('assets/images/done.svg',
            height:22,
            width: 22
        ));
    var inProgress = Container(
        padding: const EdgeInsets.only(right: 15),
        child:SvgPicture.asset('assets/images/inProgress.svg',
            height:22,
            width: 22
        ));
    var toDo = Container(
        padding: const EdgeInsets.only(right: 15),
        child:SvgPicture.asset('assets/images/toDo.svg',
            height:22,
            width: 22
        ));
    dropDown.add(done);
    dropDown.add(inProgress);
    dropDown.add(toDo);

    return dropDown;
  }



  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}

class TaskList extends StatefulWidget {
  TaskList({Key? key}) : super(key: key);

  final taskDao = TaskDao();

  @override
  TaskListState createState() => TaskListState();
}

