import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserDao {
  final DatabaseReference _usersRef =
  FirebaseDatabase.instance.ref().child('users');

  void updateName(String name){
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    _usersRef.child(uid!).update({
      "displayName": name,
    });
  }

  void updateImage(String url){
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    _usersRef.child(uid!).update({
      "image": url,
    });
  }


  Query getUserQuery() {
    return _usersRef.limitToLast(20);
  }
  
}