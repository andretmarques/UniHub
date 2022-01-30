import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'User.dart' as my;

class UserDao {
  final DatabaseReference _usersRef =
  FirebaseDatabase.instance.ref().child('users');

  Future<my.User> getLoggedUser() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    final query =_usersRef.orderByKey().equalTo(uid);
    DataSnapshot snapshot = await query.get();
    final json = snapshot.value as Map<dynamic, dynamic>;
    final user = my.User.fromJson(json[uid]);
    return user;
  }

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
    return _usersRef.orderByChild("tasksDone").limitToLast(10);
  }
  
}