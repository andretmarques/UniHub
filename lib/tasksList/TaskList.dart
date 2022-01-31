import 'TaskWidget.dart';
import 'package:flutter/material.dart';
import 'data/Task.dart';
import 'data/TasksDao.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class TaskListState extends State<TaskList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 200)),
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
