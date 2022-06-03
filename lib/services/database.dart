import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("users");

  // in use for sign up and updating data
  Future updateUserData(String name, int num) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'num': num,
    });
  }

  // User list from snapshot
  List<User> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //User(name: doc.get('name') ?? '', number: doc.get('num') ?? 0);
      //print(u);
      return User(name: doc.get('name') ?? '', num: doc.get('num') ?? 0);
    }).toList();
  }

  // get users stream
  Stream<List<User>> get users {
    return usersCollection.snapshots().map(_userListFromSnapshot);
  }
}
