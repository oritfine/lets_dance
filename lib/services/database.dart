import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../models/video.dart';
import '../models/videos.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference userVideosCollection =
      FirebaseFirestore.instance.collection("user_videos");
  final CollectionReference videosCollection =
      FirebaseFirestore.instance.collection("videos");

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

  // Future<List<Object?>> getUsersData() async {
  //   QuerySnapshot querySnapshot = await usersCollection.get();
  //   final data = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   return data;
  // }

  // ------------ user video collection ------------

  Future updateUserVideosData(Map<String, String> videos) async {
    return await userVideosCollection.doc(uid).set({
      'videos': videos,
    });
  }

  // get user document from id
  Stream<UserVideos> get userVideos {
    return userVideosCollection
        .doc(uid)
        .snapshots()
        .map(_userVideosFromSnapshot);
  }

  UserVideos _userVideosFromSnapshot(DocumentSnapshot snapshot) {
    return UserVideos(videos: snapshot.get('videos'));
  }

  List<UserVideos> _userVideosListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserVideos(videos: doc.get('videos') ?? {});
    }).toList();
  }

  //------------ videos collection ------------

  Future<void> addLike(String uid_liker, String video_id) async {
    videosCollection.doc(video_id).update({
      'likers': FieldValue.arrayUnion([uid_liker]),
      'likes': FieldValue.increment(1)
    });
  }

  Future<void> addVideoToUserVideosList(String uid, String video_id) async {
    usersCollection.doc(uid).update({
      'videos': FieldValue.arrayUnion([video_id])
    });
  }

  Future<String> addVideo(String name, String url, String user_id) async {
    DocumentReference docRef = await videosCollection.add({
      'name': name,
      'url': url,
      'likes': 0,
      'user_id': user_id,
      'likers': []
    });
    return docRef.id;
  }

  Future updateVideos(
      String name, String url, int likes, String video_id) async {
    return await videosCollection.doc(video_id).set({
      'name': name,
      'url': url,
      'likes': likes,
      'user_id': uid,
      'likers': []
    });
  }

  List<Video> _videosListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Video(
          name: doc.get('name') ?? '',
          url: doc.get('url') ?? '',
          likes: doc.get('likes') ?? 0,
          //likers: doc.get('likers') ?? [],
          user_id: doc.get('user_id') ?? '');
    }).toList();
  }

  Stream<List<Video>> get videos {
    return videosCollection.snapshots().map(_videosListFromSnapshot);
  }
}
