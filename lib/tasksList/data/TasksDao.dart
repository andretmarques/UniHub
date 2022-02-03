import 'package:firebase_database/firebase_database.dart';
import 'Task.dart';

class TaskDao {
  final DatabaseReference _tasksRef =
      FirebaseDatabase.instance.ref().child('tasks');

  void saveTask(Task task) {
    _tasksRef.push().set(task.toJson());
  }

  Query getTaskQuery() {
    return _tasksRef.limitToFirst(25);
  }

  Query getFiveTaskQuery() {
    return _tasksRef.limitToFirst(5);
  }

  Query getOwnTaskQuery(String uid) {
    return _tasksRef.orderByChild("owner").equalTo(uid);
  }
}
