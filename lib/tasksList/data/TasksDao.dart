import 'package:firebase_database/firebase_database.dart';
import 'Task.dart';

class TaskDao {
  final DatabaseReference _tasksRef =
      FirebaseDatabase.instance.ref().child('tasks');

  void saveTask(Task task) {
    _tasksRef.push().set(task.toJson());
  }

  Query getTaskQuery() {
    return _tasksRef.limitToFirst(30);
  }
}
