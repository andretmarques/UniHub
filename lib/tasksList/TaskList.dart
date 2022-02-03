import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'TaskWidget.dart';
import 'package:flutter/material.dart';
import 'data/Task.dart';
import 'data/TasksDao.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'FilterDropDown.dart';

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Container icon;
}

  List tasksDropDown = [
    Item('All Tasks',Container()),
    Item('Done',Container(
        padding: const EdgeInsets.only(right: 15),
        child:SvgPicture.asset('assets/images/done.svg',
            height:22,
            width: 22
        ))),
    Item('In Progress',Container(
        padding: const EdgeInsets.only(right: 15),
        child:SvgPicture.asset('assets/images/inProgress.svg',
            height:22,
            width: 22
        ))),
    Item('To Do',Container(
        padding: const EdgeInsets.only(right: 15),
        child:SvgPicture.asset('assets/images/toDo.svg',
            height:22,
            width: 22
        ))),
  ];

class TaskListState extends State<TaskList> {
  final ScrollController _scrollController = ScrollController();
  var currentIndex = 0;

  filterState() {
    switch (currentIndex) {
      case 0:
        return "all";
      case 1:
        return "done";
      case 2:
        return "inProgress";
      case 3:
        return "toDo";
      default:
        return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 160)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [FilterDropDown(
                icons: tasksDropDown,
                onChange: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),buildAddTask(context)]),
              const Padding(padding: EdgeInsets.only(top: 20)),
              _getTaskList(),
            ]
        ),
      ),
    );
  }

  Widget _getTaskList() {
    return Expanded(
      child: FirebaseAnimatedList(
        controller: _scrollController,
        query: widget.taskDao.getTaskQuery(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final task = Task.fromJson(json);
          var state = filterState();
          if (task.state == state || state == "all") {
            return TaskWidget(task.title, task.state);
          }
          return Container();
        },
      ),
    );
  }
}

Widget buildAddTask(BuildContext context) {
  var addTaskLogo = const Icon(Icons.add_box_outlined, size: 20, color: Color.fromRGBO(88, 84, 84, 1));

  return TextButton(
    style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(4),
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 10, right: 10)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: const BorderSide(
                  color: Colors.grey)
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        addTaskLogo,
        const Padding(padding: EdgeInsets.only(right: 5)),
        Text("Add Task",
          style: GoogleFonts.roboto(
              fontSize: 17,
              color: const Color.fromRGBO(88, 84, 84, 1)
          ),
        ),
      ],
    ),
    onPressed: () {
    },
  );
}

class TaskList extends StatefulWidget {
  TaskList({Key? key}) : super(key: key);

  final taskDao = TaskDao();

  @override
  TaskListState createState() => TaskListState();
}
