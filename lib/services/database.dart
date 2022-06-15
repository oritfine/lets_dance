import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/my_user.dart';
import '../models/user.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("users");

  // in use for sign up and updating data
  Future updateUserData(
      String name, int num /*, List<String> videos_path*/) async {
    return await usersCollection
        .doc(uid)
        .set({'name': name, 'num': num /*, 'videos_path': videos_path*/});
  }

  // User list from snapshot
  List<UserModel> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //User(name: doc.get('name') ?? '', number: doc.get('num') ?? 0);
      //print(u);
      return UserModel(
          uid: uid.toString(),
          name: doc.get('name') ?? '',
          num: doc.get('num') ?? 0);
      //videos_path: doc.get('videos_path') ?? []);
    }).toList();
  }

  // userData from snapshot
  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(
  //       uid: uid.toString(),
  //       name: snapshot.get('name'),
  //       num: snapshot.get('num'),
  //       videos_path: snapshot.get('videos_path'));
  // }
  UserModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
        uid: uid.toString(),
        name: snapshot.get('name'),
        num: snapshot.get('num'));
  }

  // get users doc stream
  Stream<List<UserModel>> get users {
    return usersCollection.snapshots().map(_userListFromSnapshot);
  }

  // get user document from id
  // Stream<UserData> get userData {
  //   return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  // }

  // get user document from id
  Stream<UserModel> get user {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
