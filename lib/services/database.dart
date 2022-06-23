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

  Future<List<dynamic>> getVideosOfUser(String uid) async {
    var mydoc = usersCollection.doc(uid);
    var snapshot = await mydoc.get();
    if (snapshot.exists) {
      var data = snapshot.data() as Map;
      if (data != null) {
        return data['videos'];
      }
    }
    return [];
  }

  Future<Video> getVideoOfUser(String video_id) async {
    var mydoc = videosCollection.doc(video_id);
    var snapshot = await mydoc.get();
    if (snapshot.exists) {
      var data = snapshot.data() as Map;
      if (data != null) {
        return Video(
            video_id: video_id,
            name: data['name'],
            url: data['url'],
            likes: data['likes'],
            likers: data['likers'],
            user_id: data['user_id']);
      }
    }
    return Video(
        video_id: '', name: '', url: '', likes: -1, likers: [], user_id: '');
  }

  // in use for sign up and updating data
  Future updateUserData(String name, int num, List<String> videos) async {
    return await usersCollection
        .doc(uid)
        .set({'name': name, 'num': num, 'videos': videos});
  }

  // User list from snapshot
  List<UserModel> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserModel(
          uid: uid.toString(),
          name: doc.get('name') ?? '',
          num: doc.get('num') ?? 0,
          videos: doc.get('videos_path') ?? []);
    }).toList();
  }

  UserModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    print('videos is:');
    print(snapshot.get('videos'));
    return UserModel(
        uid: uid.toString(),
        name: snapshot.get('name') ?? '',
        num: snapshot.get('num') ?? 0,
        videos: snapshot.get('videos') ?? []);
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
    //return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
    return usersCollection
        .doc(uid)
        .snapshots()
        .map(_userDataFromSnapshot); //: Stream<UserModel>.value(null);
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

  Future<void> removeMyVideo(String uid, String video_id) async {
    videosCollection.doc(video_id).delete();
    usersCollection.doc(uid).update({
      'videos': FieldValue.arrayRemove([video_id])
    });
  }

  Future<void> removeLike(String uid_liker, String video_id) async {
    videosCollection.doc(video_id).update({'likes': FieldValue.increment(-1)});
  }

  // return new likers list length
  Future<int> removeLiker(String uid_liker, String video_id) async {
    videosCollection.doc(video_id).update({
      'likers': FieldValue.arrayRemove([uid_liker]),
    });
    var mydoc = videosCollection.doc(video_id);
    var snapshot = await mydoc.get();
    if (snapshot.exists) {
      var data = snapshot.data() as Map;
      if (data != null) {
        return data['likers'].length;
      }
    }
    return -1;
  }

  Future<void> addLike(String uid_liker, String video_id) async {
    videosCollection.doc(video_id).update({'likes': FieldValue.increment(1)});
  }

  // return new likers list length
  Future<int> addLiker(String uid_liker, String video_id) async {
    videosCollection.doc(video_id).update({
      'likers': FieldValue.arrayUnion([uid_liker]),
      //'likes': FieldValue.increment(1)
    });

    var mydoc = videosCollection.doc(video_id);
    var snapshot = await mydoc.get();
    if (snapshot.exists) {
      var data = snapshot.data() as Map;
      if (data != null) {
        return data['likers'].length;
      }
    }
    return -1;
  }

  Future<void> addVideoToUserVideosList(String uid, String video_id) async {
    usersCollection.doc(uid).update({
      'videos': FieldValue.arrayUnion([video_id])
    });
  }

  Future updateVideoIdField(String video_id) async {
    return await videosCollection.doc(video_id).set({
      'video_id': video_id,
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
    updateVideoIdField(docRef.id);
    print('new video_id:' + docRef.id);
    print('uid that created the new video:' + user_id);
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
          video_id: doc.id,
          name: doc.get('name') ?? '',
          url: doc.get('url') ?? '',
          likes: doc.get('likes') ?? 0,
          likers: doc.get('likers') ?? [],
          user_id: doc.get('user_id') ?? '');
    }).toList();
  }

  Stream<List<Video>> get videos {
    return videosCollection.snapshots().map(_videosListFromSnapshot);
  }
}
