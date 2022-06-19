import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lets_dance/screens/upload_video/avatar_tile.dart';
import 'package:lets_dance/screens/upload_video/choose_face.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lets_dance/services/storage.dart';
import '../../shared/designs.dart';

class ChooseAvatar extends StatefulWidget {
  final String uid;
  final String username;
  final VideoPlayerController videoPlayerController;
  final String backgroundName;

  ChooseAvatar(
      {required this.uid,
      required this.username,
      required this.videoPlayerController,
      required this.backgroundName});

  @override
  _ChooseAvatarState createState() => _ChooseAvatarState();
}

class _ChooseAvatarState extends State<ChooseAvatar> {
  String serverUrl = '';
  bool isNextActive = false;
  int selectedIndex = -1;
  final Storage storage = Storage();

  List<String> avatarNames = [
    'Green',
    'Pink-Lightblue-Yellow',
    'Green-Pink-Red',
    'Purple-Blue'
  ];

  void selectIndex(int index) {
    setState(() {
      selectedIndex = index;
      isNextActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      appBar: AppBarDesign(text: 'Choose Avatar'),
      body: Padding(
        padding: EdgeInsets.only(left: 30, top: 20, right: 30),
        child: Column(
          children: [
            TextDesign(text: 'Choose an avatar for your video:', size: 18),
            SizedBox(height: 18),
            Container(
              height: MediaQuery.of(context).size.height * 0.69,
              width: MediaQuery.of(context).size.width * 0.85,
              child: GridView.count(
                primary: false,
                //padding: const EdgeInsets.all(400),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                crossAxisCount: 2,
                childAspectRatio: (100.0 / 175.0),
                children: [
                  for (int i = 0; i < 4; i++)
                    AvatarTile(
                      avatarPath: 'images/avatars/${avatarNames[i]}.png',
                      onTap: () => selectIndex(i),
                      selected: i == selectedIndex,
                      avatarName: avatarNames[i],
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.only(left: 250),
              child: ElevatedButton(
                  style: isNextActive ? button_style : disabled_next_style,
                  child: TextDesign(text: 'Next', size: 18),
                  onPressed: isNextActive
                      ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChooseFace(
                                        videoPlayerController:
                                            widget.videoPlayerController,
                                        backgroundName:
                                            selectedIndex.toString() + '.jpg',
                                        avatarName:
                                            avatarNames[selectedIndex] + '.png',
                                        serverUrl: serverUrl,
                                        uid: widget.uid,
                                        username: widget.username,
                                      )));
                        }
                      : () {}),
            ),
          ],
        ),
      ),
    );
  }
}
