import 'package:firebase_database/firebase_database.dart';
import 'Transaction.dart' as my;

class TransactionDao {
  final DatabaseReference _tasksRef =
      FirebaseDatabase.instance.ref().child('transactions');

  void saveTask(my.Transaction transaction) {
    _tasksRef.push().set(transaction.toJson());
  }

  Query getTaskQuery() {
    return _tasksRef.limitToFirst(10);
  }

  Query getOwnTransactionsQuery(String uid) {
    return _tasksRef.orderByChild("owner").equalTo(uid);
  }
}
