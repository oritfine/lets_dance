import 'package:flutter/material.dart';
import 'package:lets_dance/screens/my_videos.dart';
import 'package:lets_dance/screens/upload_video/browse_video_prev.dart';
import 'package:lets_dance/shared/menu/menu_item.dart';

import '../../screens/upload_video/browse_video.dart';
import '../../services/auth.dart';
import '../designs.dart';

class NavigationMenu extends StatelessWidget {
  NavigationMenu(
      {Key? key,
      required this.auth,
      required this.email,
      required this.username,
      required this.uid});
  final AuthService auth;
  final String? email;
  final String? username;
  final String uid;

  // Navigate by index which was sent to function
  void onItemPressed(BuildContext context, {required int index}) {
    //Navigator.pop(context);
    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyVideos(uid: uid)));
        break;
      case 1:
        Navigator.push(
            //context, MaterialPageRoute(builder: (context) => BrowseVideo()));
            context,
            MaterialPageRoute(
                builder: (context) =>
                    BrowseVideo(uid: uid, username: username!)));
        break;
      case 2:
        break;
      default:
        Navigator.pop(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[700],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            headerWidget(context),
            ItemsWidget(context),
          ],
        ),
      ),
    );
  }

  Widget headerWidget(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Padding(
          padding: /*const*/ EdgeInsets.all(30.0),
          // padding: EdgeInsets.only(top:24+ MediaQuery.of(context).padding.top, bottom: 24),
          child: Row(
            children: [
              CircleAvatar(radius: 35, backgroundColor: Colors.pink),
              /*const*/ SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextDesign(text: username!, size: 20),
                  SizedBox(
                    height: 10,
                  ),
                  TextDesign(text: email!, size: 18),
                ],
              )
            ],
          ),
        ),
      );
  Widget ItemsWidget(BuildContext context) => Container(
        padding: /*const*/ EdgeInsets.only(left: 40, right: 40),
        child: Column(
          children: [
            /*const*/ Divider(color: Colors.grey),
            SizedBox(
              height: 20,
            ),
            MyMenuItem(
              name: 'My Videos',
              icon: Icons.video_collection,
              onPressed: () => onItemPressed(context, index: 0),
            ),
            SizedBox(height: 10),
            MyMenuItem(
              name: 'Create New Video',
              icon: Icons.video_call,
              onPressed: () => onItemPressed(context, index: 1),
            ),
            SizedBox(height: 10),
            MyMenuItem(
              name: 'Log Out',
              icon: Icons.person,
              onPressed: () async {
                await auth.signOut();
              },
            )
          ],
        ),
      );
}
