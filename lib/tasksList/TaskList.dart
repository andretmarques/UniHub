import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'TaskWidget.dart';
import 'package:flutter/material.dart';
import 'data/Task.dart';
import 'data/TasksDao.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'dropDownTest.dart';

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Container icon;
}

  List tasksDropDown = [
    Item('Done',Container(
        padding: const EdgeInsets.only(right: 15),
        child:SvgPicture.asset('assets/images/done.svg',
            height:22,
            width: 22
        ))),
    Item('inProgress',Container(
        padding: const EdgeInsets.only(right: 15),
        child:SvgPicture.asset('assets/images/inProgress.svg',
            height:22,
            width: 22
        ))),
    Item('ToDo',Container(
        padding: const EdgeInsets.only(right: 15),
        child:SvgPicture.asset('assets/images/toDo.svg',
            height:22,
            width: 22
        ))),
  ];

class TaskListState extends State<TaskList> {
  final ScrollController _scrollController = ScrollController();
  var dropdownValue = "All Tasks";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 200)),
              SimpleAccountMenu(
                icons: tasksDropDown,
                onChange: (index) {
                  print(index);
                }, borderRadius: BorderRadius.zero, key: const Key("1"),
              ),
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
}

class TaskList extends StatefulWidget {
  TaskList({Key? key}) : super(key: key);

  final taskDao = TaskDao();

  @override
  TaskListState createState() => TaskListState();
}

