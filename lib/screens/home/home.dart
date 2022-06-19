import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_dance/screens/home/userlist.dart';
import 'package:lets_dance/services/auth.dart';
import 'package:lets_dance/services/database.dart';
import 'package:lets_dance/shared/menu/navigation_menu.dart';
import 'package:provider/provider.dart';
import '../../feed.dart';
import '../../models/user.dart';
import '../../models/video.dart';
import '../../models/videos.dart';
import '../../shared/designs.dart';
import '../videos_list.dart';

class Home extends StatelessWidget {
  //const ({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();
  final FirebaseAuth firebase_auth = FirebaseAuth.instance;
  final DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 70.0, horizontal: 60.0),
              child: Text('bottom sheet'),
            );
          });
    }

    return StreamProvider<List<Video>>.value(
      // listening to stream of users which will reflect the firestore collection
      value: DatabaseService().videos,
      catchError: (_, err) => null,
      child: Scaffold(
        drawer: NavigationMenu(
            auth: _auth,
            email: firebase_auth.currentUser?.email,
            username: firebase_auth.currentUser?.displayName,
            uid: firebase_auth.currentUser!.uid),
        backgroundColor: background_color,
        appBar: AppBar(
          title: TextDesign(text: 'Lets Dance', size: 24),
          centerTitle: true,
          //backgroundColor: Color.fromRGBO(143, 78, 208, 0.9),
          //backgroundColor: Color.fromRGBO(141, 70, 234, 1.0),
          backgroundColor: appbar_color,
          elevation: 0.0,
          actions: <Widget>[
            // TextButton.icon(
            //     icon: Icon(
            //       Icons.person,
            //       color: Colors.grey[900],
            //     ),
            //     onPressed: () async {
            //       await _auth.signOut();
            //     },
            //     label:
            //         Text('Log Out', style: TextStyle(color: Colors.grey[900]))),
            TextButton.icon(
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey[900],
                ),
                onPressed: () => _showSettingsPanel(),
                label:
                    Text('Settings', style: TextStyle(color: Colors.grey[900])))
          ],
        ),
        body: Column(
          children: [
            ElevatedButton(
              //style: ElevatedButton.styleFrom(primary: Colors.pink[400]),
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(87, 72, 231, 1.0)),
              child: Text(
                'Upload New Video',
                style: TextStyle(color: Colors.grey[300]),
              ),
              onPressed: () async {
                String video_id = await _db.addVideo(
                    'video',
                    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                    firebase_auth.currentUser!.uid) as String;
                _db.usersCollection.doc(firebase_auth.currentUser!.uid).update({
                  'videos': FieldValue.arrayUnion([video_id])
                });
                // Map<String, String> videos = {
                //   'video1': 'url1',
                //   'video2': 'url2',
                //   'video3': 'url3'
                // };
                //_db.updateUserVideosData(videos);
                // _db.updateVideos(
                //     'video2', 'videos/final_maddie1_smoothed.mp4', 0);
                // _db.updateVideos('video3', 'videos/final_slidin_g.mp4', 5);
                // _db.updateVideos(
                //     'video4', 'videos/final_slidin_g_smoothed.mp4', 2);
              },
            ),
            Container(
              height: 600,
              //child: MyVideosList(uid: firebase_auth.currentUser?.uid),
              child: //VideoList(),
                  Container(),
            ),
          ],
        ),
      ),
    );
  }
}
