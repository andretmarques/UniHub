import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'User.dart';

class UserDao {
  final DatabaseReference _usersRef =
  FirebaseDatabase.instance.ref().child('users');

  void saveUser(User user) {
    _usersRef.push().set(user.toJson());
  }

  Query getUserQuery() {
    return _usersRef.orderByChild("tasksDone");
  }
  
}