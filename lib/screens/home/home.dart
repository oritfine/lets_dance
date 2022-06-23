import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_dance/services/auth.dart';
import 'package:lets_dance/services/database.dart';
import 'package:lets_dance/shared/menu/navigation_menu.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../feed.dart';
import '../../models/user.dart';
import '../../models/video.dart';
import '../../shared/designs.dart';
import '../upload_video/save_video.dart';
import '../videos_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final FirebaseAuth firebase_auth = FirebaseAuth.instance;
  final DatabaseService _db = DatabaseService();
  bool taped = false;
  List<Video> videos = [];

  void onTap(videos_list) {
    if (!taped) {
      setState(() {
        print('set videos_list');
        videos = videos_list;
        if (videos != null) {
          taped = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // void _showSettingsPanel() {
    //   showModalBottomSheet(
    //       context: context,
    //       builder: (context) {
    //         return Container(
    //           padding: EdgeInsets.symmetric(vertical: 70.0, horizontal: 60.0),
    //           child: Text('bottom sheet'),
    //         );
    //       });
    // }

    return StreamProvider<List<Video>>.value(
      // listening to stream of users which will reflect the firestore collection
      value: DatabaseService().videos,
      catchError: (_, err) => null,
      child: Scaffold(
        drawer: NavigationMenu(
            auth: _auth,
            email: firebase_auth.currentUser?.email,
            username: firebase_auth.currentUser?.displayName,
            uid: firebase_auth.currentUser!.uid,
            videos: videos),
        backgroundColor: background_color,
        appBar: AppBar(
          title: TextDesign(text: 'Lets-Dance', size: 24),
          centerTitle: true,
          //backgroundColor: Color.fromRGBO(143, 78, 208, 0.9),
          //backgroundColor: Color.fromRGBO(141, 70, 234, 1.0),
          backgroundColor: appbar_color,
          elevation: 0.0,
          // actions: <Widget>[
          //   // TextButton.icon(
          //   //     icon: Icon(
          //   //       Icons.person,
          //   //       color: Colors.grey[900],
          //   //     ),
          //   //     onPressed: () async {
          //   //       await _auth.signOut();
          //   //     },
          //   //     label:
          //   //         Text('Log Out', style: TextStyle(color: Colors.grey[900]))),
          //   TextButton.icon(
          //       icon: Icon(
          //         Icons.settings,
          //         color: Colors.grey[900],
          //       ),
          //       onPressed: () => _showSettingsPanel(),
          //       label: Text('Settings',
          //           style: GoogleFonts.josefinSans(
          //               fontWeight: FontWeight.w700,
          //               fontSize: 16,
          //               color: Colors.grey[900])))
          // ],
        ),
        body: Column(
          children: [
            ElevatedButton(
              //style: ElevatedButton.styleFrom(primary: Colors.pink[400]),
              style: ElevatedButton.styleFrom(primary: button_color),
              child: Text(
                'Upload New Video',
                style: TextStyle(color: Colors.grey[300]),
              ),
              onPressed: () async {
                //_db.getVideosOfUser('KrWc0wp9MhXxCWhNQ5q8qTt7Iyj1');
                // Video v = await _db.getVideoOfUser('1PiM5YGDtbRF2lC7esMu');
                // print('yey');
                // // VideoPlayerController videoPlayerController =
                //     VideoPlayerController.network(
                //         'https://09dd-2a02-6680-2109-a7cb-3956-c0bd-dc1d-fbd6.eu.ngrok.io/get_video?url=final_yanir_1655739133326.mp4')
                //       ..initialize();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SaveVideo(
                              url:
                                  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                              //videoPlayerController: videoPlayerController,
                              uid: 'KrWc0wp9MhXxCWhNQ5q8qTt7Iyj1',
                            )));
                // String video_id = await _db.addVideo(
                //     'video',
                //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                //     firebase_auth.currentUser!.uid) as String;
                // _db.usersCollection.doc(firebase_auth.currentUser!.uid).update({
                //   'videos': FieldValue.arrayUnion([video_id])
                // });
              },
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              //child: MyVideosList(uid: firebase_auth.currentUser?.uid),
              child: VideoList(
                uid: firebase_auth.currentUser!.uid,
                onTap: onTap,
                username: firebase_auth.currentUser?.displayName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
